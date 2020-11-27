<?xml version="1.0" encoding="us-ascii"?>

<xsl:transform version="1.0" 
							 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
							 xmlns:v3="urn:hl7-org:v3" 
							 xmlns:v="http://validator.pragmaticdata.com/result" 
							 xmlns:str="http://exslt.org/strings" 
							 xmlns:exsl="http://exslt.org/common" 
							 xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
							 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
							 exclude-result-prefixes="exsl msxsl v3 xsl xsi str v">
	<xsl:param name="show-subjects-xml" select="1"/>
	<xsl:param name="show-data" select="/.."/>
	<xsl:param name="show-section-numbers" select="/.."/>
	<xsl:param name="update-check-url-base" select="/.."/>
	<xsl:param name="root" select="/"/>
	<xsl:param name="process-mixins" select="/.."/>
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="no" doctype-public="-"/>
	<xsl:strip-space elements="*"/>
	<xsl:variable name="timeUnitsList">
		<unitsMapping>
			<unit UCUM="s" singular="second" plural="seconds"/>
			<unit UCUM="min" singular="minute" plural="minutes"/>
			<unit UCUM="h" singular="hour" plural="hours"/>
			<unit UCUM="d" singular="day" plural="days"/>
			<unit UCUM="wk" singular="week" plural="weeks"/>
			<unit UCUM="mo" singular="month" plural="months"/>
			<unit UCUM="a" singular="year" plural="years"/>
		</unitsMapping>
	</xsl:variable>
	<!-- Removed a number of unused variables and process mixins -->

	<!-- MAIN MODE based on the deep null-transform -->
	<xsl:template match="/|@*|node()">
		<xsl:apply-templates select="@*|node()"/>
	</xsl:template>
	<!-- GS: the document title should not be processed in normal mode. 
			 This is really should be revisited when the top-level template gets refactored. --> 
	<xsl:template match="/v3:document/v3:title" priority="1"/>

	<!-- Removed all of the main document targets, since spl_canada has its own -->
	<!-- Removed observation Criterion and Analyte templates -->
	<!-- Removed Pesticides label and REMS templates -->
	<!-- helper templates -->
	<xsl:template priority="2" match="v3:highlight//@width[not(contains(.,'%'))]" /> <!-- This would avoid things moving out of 2-column view -->
	<xsl:template mode="twocolumn" match="/|node()|@*">
		<xsl:param name="class"/>
		<xsl:copy>
			<xsl:apply-templates mode="twocolumn" select="@*|node()">
				<xsl:with-param name="class" select="$class"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

	<!-- Moved string-lowercase and string-uppercase templates into internationalization file to support French language characters -->
	<xsl:template name="printSeperator">
		<xsl:param name="lastDelimiter"><xsl:if test="last() > 2">,</xsl:if> and </xsl:param>
		<xsl:choose>
			<xsl:when test="position() = last() - 1"><xsl:value-of select="$lastDelimiter"/></xsl:when>
			<xsl:when test="position() &lt; last() - 1">, </xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Moved string-to-date into a localization file spl_canada_i18n.xsl to support international requirements -->
	<xsl:template name="recent-effectiveDate">
		<xsl:param name="effectiveDateSequence" />
		<xsl:for-each select="$effectiveDateSequence[string-length(.) &gt; 7]">
			<xsl:sort select="." order="descending"/>
			<xsl:if test="position() = 1">
				<v3:effectiveTime value="{.}" />
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="max">
		<xsl:param name="sequence" />
		<xsl:for-each select="$sequence">
			<xsl:sort select="." data-type="number" order="descending" />
			<xsl:if test="position()=1">
				<xsl:value-of select="." />
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="format" match="*/v3:addr">
		<table>
			<tr><td>Address:</td><td><xsl:value-of select="./v3:streetAddressLine"/></td></tr>
			<tr><td>City, State, Zip:</td>
				<td>
					<xsl:value-of select="./v3:city"/>
					<xsl:if test="string-length(./v3:state)>0">,&#160;<xsl:value-of select="./v3:state"/></xsl:if>
					<xsl:if test="string-length(./v3:postalCode)>0">,&#160;<xsl:value-of select="./v3:postalCode"/></xsl:if>
				</td>
			</tr>
			<tr><td>Country:</td><td><xsl:value-of select="./v3:country"/></td></tr>
		</table>
	</xsl:template>

	<!-- Removed highlights and index templates -->
	<!-- MODE: reference -->
	<!-- Create a section number reference such as (13.2) -->
	<xsl:template mode="reference" match="/|@*|node()">
		<xsl:text> (</xsl:text>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<a href="#section-{substring($sectionNumberSequence,2)}">
			<xsl:value-of select="substring($sectionNumberSequence,2)"/>
		</a>
		<xsl:text>)</xsl:text>
	</xsl:template>

	<!-- styleCode processing: styleCode can be a list of tokens that
			 are being combined into a single css class attribute. To 
			 come to a normalized combination we sort the tokens. 

Step 1: combine the attribute supplied codes and additional
codes in a single token list.

Step 2: split the token list into XML elements

Step 3: sort the elements and turn into a single combo
token.
	-->
	<xsl:template match="@styleCode" name="styleCodeAttr">
		<xsl:param name="styleCode" select="."/>
		<xsl:param name="additionalStyleCode" select="/.."/>
		<xsl:param name="allCodes" select="normalize-space(concat($additionalStyleCode,' ',$styleCode))"/>
		<xsl:param name="additionalStyleCodeSequence" select="/.."/>
		<xsl:variable name="splitRtf">
			<xsl:if test="$allCodes">
				<xsl:call-template name="splitTokens">
					<xsl:with-param name="text" select="$allCodes"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:for-each select="$additionalStyleCodeSequence">
				<token value="{concat(translate(substring(current(),1,1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring(current(),2))}"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="function-available('exsl:node-set')">
					<xsl:variable name="sortedTokensRtf">
						<xsl:for-each select="exsl:node-set($splitRtf)/token">
							<xsl:sort select="@value"/>
							<xsl:copy-of select="."/>
						</xsl:for-each>
					</xsl:variable>
					<xsl:call-template name="uniqueStyleCodes">
						<xsl:with-param name="in" select="exsl:node-set($sortedTokensRtf)"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="function-available('msxsl:node-set')">
					<xsl:variable name="sortedTokensRtf">
						<xsl:for-each select="msxsl:node-set($splitRtf)/token">
							<xsl:sort select="@value"/>
							<xsl:copy-of select="."/>
						</xsl:for-each>
					</xsl:variable>
					<xsl:call-template name="uniqueStyleCodes">
						<xsl:with-param name="in" select="msxsl:node-set($sortedTokensRtf)"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<!-- this one below should work for all parsers as it is using exslt but will keep the above code for msxsl for now -->
					<xsl:message>WARNING: missing required function node-set, this xslt processor may not work correctly</xsl:message>
					<xsl:for-each select="str:tokenize($allCodes, ' ')">
						<xsl:sort select="."/>
						<xsl:copy-of select="."/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="string-length($class) > 0">
				<xsl:attribute name="class">
					<xsl:value-of select="normalize-space($class)"/>
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="string-length($allCodes) > 0">
				<xsl:attribute name="class">
					<xsl:value-of select="normalize-space($allCodes)"/>
				</xsl:attribute>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Moved additionalStyleAttr to spl_canada -->
	<xsl:template name="uniqueStyleCodes">
		<xsl:param name="in" select="/.."/>
		<xsl:for-each select="$in/token[not(preceding::token/@value = @value)]">
			<xsl:value-of select="@value"/><xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="splitTokens">
		<xsl:param name="text" select="."/>
		<xsl:param name="firstCode" select="substring-before($text,' ')"/>
		<xsl:param name="restOfCodes" select="substring-after($text,' ')"/>
		<xsl:choose>
			<xsl:when test="$firstCode">
				<token
						value="{concat(translate(substring($firstCode,1,1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($firstCode,2))}"/>
				<xsl:if test="string-length($restOfCodes) > 0">
					<xsl:call-template name="splitTokens">
						<xsl:with-param name="text" select="$restOfCodes"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<token value="{concat(translate(substring($text,1,1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($text,2))}"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Removed related document templates -->
	
	<xsl:template name="headerString">
		<xsl:param name="curProduct">.</xsl:param>
		<xsl:value-of select="$curProduct/v3:name"/>
		<xsl:value-of select="$curProduct/v3:formCode/@code"/>
		<xsl:choose>
			<xsl:when test="$curProduct/v3:part">
				<xsl:value-of select="$curProduct/v3:asEntityWithGeneric/v3:genericMedicine/v3:name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$curProduct/*[self::v3:ingredient[starts-with(@classCode, 'ACTI')] or self::v3:activeIngredient]">
					<xsl:call-template name="string-lowercase">
						<xsl:with-param name="text" select="(v3:ingredientSubstance|v3:activeIngredientSubstance)/v3:name"/>
					</xsl:call-template> 
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	<xsl:template name="regMedNames">	
		<xsl:variable name="medName">
			<xsl:call-template name="string-uppercase">
				<xsl:with-param name="text">
					<xsl:copy><xsl:apply-templates mode="specialCus" select="./v3:name" /></xsl:copy>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="$medName"/>
		<xsl:if test="./v3:name/v3:suffix">&#160;</xsl:if>
		<xsl:call-template name="string-uppercase">
			<xsl:with-param name="text"
											select="./v3:name/v3:suffix"/>
		</xsl:call-template> 
		<xsl:text>- </xsl:text>
		<xsl:choose>
		    <xsl:when test="v3:asEntityWithGeneric/v3:genericMedicine/v3:name">
				<xsl:call-template name="string-lowercase">
				  <xsl:with-param name="text" select="./v3:asEntityWithGeneric/v3:genericMedicine/v3:name|v3:asSpecializedKind/v3:generalizedMaterialKind/v3:code[@codeSystem = '2.16.840.1.113883.6.276' or @codeSystem = '2.16.840.1.113883.6.303']/@displayName"/>
				 </xsl:call-template>
			</xsl:when>
			<xsl:when test="v3:ingredient[starts-with(@classCode, 'ACTI')]|v3:activeIngredient">
				<xsl:for-each select="v3:ingredient[starts-with(@classCode, 'ACTI')]|v3:activeIngredient">
					<xsl:choose>
						<xsl:when test="position() > 1 and  position() = last()">
							<xsl:text> and </xsl:text>
						</xsl:when>
						<xsl:when test="position() > 1">
							<xsl:text>, </xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:call-template name="string-lowercase">
						<xsl:with-param name="text" select="*[self::v3:ingredientSubstance or self::v3:activeIngredientSubstance]/v3:name"/>
					</xsl:call-template> 
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="genMedName">
					<xsl:call-template name="string-uppercase">
						<xsl:with-param name="text" select="./v3:asEntityWithGeneric/v3:genericMedicine/v3:name|v3:asSpecializedKind/v3:generalizedMaterialKind/v3:code[@codeSystem = '2.16.840.1.113883.6.276' or @codeSystem = '2.16.840.1.113883.6.303']/@displayName"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$medName != $genMedName">
						<xsl:call-template name="string-lowercase">
							<xsl:with-param name="text"
															select="$genMedName"
															/>
						</xsl:call-template> 
					</xsl:when>
					<xsl:otherwise>&#160;</xsl:otherwise>
				</xsl:choose>&#160;
			</xsl:otherwise>
		</xsl:choose>&#160;<xsl:if test="not(v3:part)">
			<xsl:call-template name="string-lowercase">
				<xsl:with-param name="text"
												select="./v3:formCode/@displayName"/>
			</xsl:call-template>
			<xsl:text>&#160;</xsl:text>
		</xsl:if>
	</xsl:template>	
	<xsl:template mode="specialCus" match="v3:name">
		<xsl:value-of select="text()"/>
	</xsl:template>	

	<xsl:template name="titleNumerator">
		<xsl:for-each
				select="./v3:activeIngredient[(./v3:quantity/v3:numerator/@unit or ./v3:quantity/v3:denominator/@unit) and (./v3:quantity/v3:numerator/@unit != '' or ./v3:quantity/v3:denominator/@unit != '') and (./v3:quantity/v3:numerator/@unit != '1' or ./v3:quantity/v3:denominator/@unit != '1')]">
			<xsl:if test="position() = 1">&#160;</xsl:if>
			<xsl:if test="position() > 1">&#160;/&#160;</xsl:if>
			<xsl:value-of select="./v3:quantity/v3:numerator/@value"/>
			<xsl:if test="./v3:quantity/v3:numerator/@unit">&#160;<xsl:value-of select="./v3:quantity/v3:numerator/@unit"/></xsl:if>
			<xsl:if test="./v3:quantity/v3:denominator/@unit != '' and ./v3:quantity/v3:denominator/@unit != '1'">
				<xsl:text>&#160;per&#160;</xsl:text>
				<xsl:value-of select="./v3:quantity/v3:denominator/@value"/>
				<xsl:text>&#160;</xsl:text>
				<xsl:value-of select="./v3:quantity/v3:denominator/@unit"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="consumedIn">
		<xsl:for-each select="../v3:consumedIn">
			<span class="titleCase">
				<xsl:call-template name="string-lowercase">
					<xsl:with-param name="text" select="./v3:substanceAdministration/v3:routeCode/@displayName"/>
				</xsl:call-template>
			</span>
			<xsl:call-template name="printSeperator"/>
		</xsl:for-each>
	</xsl:template>

	<!-- FOOTNOTES -->
	<xsl:param name="footnoteMarks" select="'*&#8224;&#8225;&#167;&#182;#&#0222;&#0223;&#0224;&#0232;&#0240;&#0248;&#0253;&#0163;&#0165;&#0338;&#0339;&#0393;&#0065;&#0066;&#0067;&#0068;&#0069;&#0070;&#0071;&#0072;&#0073;&#0074;&#0075;&#0076;&#0077;&#0078;&#0079;&#0080;&#0081;&#0082;&#0083;&#0084;&#0085;&#0086;&#0087;&#0088;&#0089;&#0090;'"/>
	<xsl:template name="footnoteMark">
		<xsl:param name="target" select="."/>
		<xsl:for-each select="$target[1]">
		<xsl:choose>
				<xsl:when test="ancestor::v3:title[parent::v3:document]">
					<!-- innermost table - FIXME: does not work for the constructed tables -->
					<xsl:variable name="number" select="count(preceding::v3:footnote)+1"/>
					<xsl:value-of select="substring($footnoteMarks,$number,1)"/>
				</xsl:when>
				<xsl:when test="ancestor::v3:table">
					<!-- innermost table - FIXME: does not work for the constructed tables -->
					<xsl:variable name="number">
						<xsl:number level="any" from="v3:table" count="v3:footnote"/>
					</xsl:variable>
					<xsl:value-of select="substring($footnoteMarks,$number,1)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(preceding::v3:footnote[not(ancestor::v3:table or ancestor::v3:title[parent::v3:document])])+1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- changed by Brian Suggs 11-16-05.  Added the [name(..) != 'text']  -->
	<!-- PCR 601 Not displaying foonote mark inside a  table of content -->
	<xsl:template match="v3:footnote[name(..) != 'text']">
		<xsl:param name="isTableOfContent2"/>
		<xsl:if test="$isTableOfContent2!='yes'">
			<xsl:variable name="mark">
				<xsl:call-template name="footnoteMark"/>
			</xsl:variable>
			<xsl:variable name="globalnumber" select="count(preceding::v3:footnote)+1"/>
			<a name="footnote-reference-{$globalnumber}" href="#footnote-{$globalnumber}" class="Sup">
				<xsl:value-of select="$mark"/>
			</a>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v3:footnoteRef">
		<xsl:variable name="ref" select="@IDREF"/>
		<xsl:variable name="target" select="//v3:footnote[@ID=$ref]"/>
		<xsl:variable name="mark">
			<xsl:call-template name="footnoteMark">
				<xsl:with-param name="target" select="$target"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="globalnumber" select="count($target/preceding::v3:footnote)+1"/>
		<a href="#footnote-{$globalnumber}" class="Sup">
			<xsl:value-of select="$mark"/>
		</a>
	</xsl:template>
	<xsl:template name="flushSectionTitleFootnotes">
		<xsl:variable name="footnotes" select="./v3:title/v3:footnote[not(ancestor::v3:table)]"/>
		<xsl:if test="$footnotes">
			<hr class="Footnoterule"/>
			<dl class="Footnote">
				<xsl:apply-templates mode="footnote" select="$footnotes"/>
			</dl>
		</xsl:if>
	</xsl:template>
	<xsl:template name="flushDocumentTitleFootnotes">
		<xsl:variable name="footnotes" select="/v3:document/v3:title//v3:footnote"/>
		<xsl:if test="$footnotes">
			<br/>
			<dl class="Footnote">
				<xsl:apply-templates mode="footnote" select="$footnotes"/>
			</dl>
		</xsl:if>
	</xsl:template>
	<!-- comment added by Brian Suggs on 11-11-05: The flushfootnotes template is called at the end of every section -->
	<xsl:template match="v3:flushfootnotes" name="flushfootnotes">
		<xsl:variable name="footnotes" select=".//v3:footnote[not(ancestor::v3:table)]"/>
		<xsl:if test="$footnotes">
			<hr class="Footnoterule"/>
			<dl class="Footnote">
				<xsl:apply-templates mode="footnote" select="$footnotes"/>
			</dl>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="footnote" match="/|node()">
		<xsl:apply-templates mode="footnote" select="node()"/>
	</xsl:template>
	<xsl:template mode="footnote" match="v3:footnote">
		<xsl:variable name="mark">
			<xsl:call-template name="footnoteMark"/>
		</xsl:variable>
		<xsl:variable name="globalnumber" select="count(preceding::v3:footnote)+1"/>
		<dt>
			<a name="footnote-{$globalnumber}" href="#footnote-reference-{$globalnumber}">
				<xsl:value-of select="$mark"/>
			</a>
		</dt>
		<dd>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</dd>
	</xsl:template>
	<xsl:template mode="footnote" match="v3:section|v3:table"/>

	<!-- CROSS REFERENCE linkHtml -->
	<xsl:template name="reference" mode="mixed" match="v3:linkHtml[@href]">
		<xsl:param name="current" select="current()"/>
		<xsl:param name="href" select="$current/@href"/>
		<xsl:param name="target" select="//*[@ID=substring-after($href,'#')]"/>
		<xsl:param name="styleCode" select="$current/@styleCode"/>
		<xsl:variable name="targetTable" select="$target/self::v3:table"/>
		<xsl:choose>
			<xsl:when test="$targetTable and self::v3:linkHtml and $current/node()">
				<a href="#{$targetTable/@ID}">
					<xsl:apply-templates mode="mixed" select="$current/node()"/>
				</a>
			</xsl:when>
			<!-- see PCR 793, we don't generate anchor anymore, we just use what's in the spl -->
			<xsl:otherwise>
				<xsl:variable name="sectionNumberSequence">
					<xsl:apply-templates mode="sectionNumber" select="$target/ancestor-or-self::v3:section"/>
				</xsl:variable>
				<xsl:variable name="nhref">
					<xsl:choose>
						<xsl:when test="starts-with( $href, '#')">							
							<xsl:value-of select="$href"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="contains(@href, 'http')">
									<xsl:value-of select="@href"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat('http://',@href)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- XXX: can we match the style of the headings? -->
				<a href="{$nhref}">
					<xsl:if test="contains($styleCode,'MainTitle') and $target/ancestor-or-self::v3:section[last()]/v3:title">
						<xsl:value-of select="$target/ancestor-or-self::v3:section[last()]/v3:title"/>
					</xsl:if>
					<xsl:if test="contains($styleCode,'SubTitle') and $target/v3:title">
						<xsl:if test="contains($styleCode,'MainTitle') and $target/ancestor-or-self::v3:section[last()]/v3:title">
							<xsl:text>: </xsl:text>
						</xsl:if>
						<xsl:value-of select="$target/v3:title"/>
					</xsl:if>
					<xsl:if test="contains($styleCode,'Number') and $target/ancestor-or-self::v3:section[last()]/v3:title">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="substring($sectionNumberSequence,2)"/>
						<xsl:text>)</xsl:text>
					</xsl:if>
					<xsl:if test="self::v3:linkHtml">
						<xsl:apply-templates mode="mixed" select="$current/node()"/>
					</xsl:if>
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Moved Section Model numbering and templates to xpl_canada.xsl -->
	<!-- We could also move the "title" and "text" templates to spl_canada.xsl as well, but they have child apply-templates -->
	<xsl:template match="v3:title">
		<xsl:param name="sectionLevel" select="count(ancestor::v3:section)"/>
		<xsl:param name="sectionNumber" select="/.."/>
		<xsl:element name="h{$sectionLevel}">
			<xsl:if test="$root/v3:document[v3:code/@code = '3565717']">
				<xsl:attribute name="style">display: inline;</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*"/>
			<xsl:if test="boolean($show-section-numbers) and $sectionNumber">
				<span class="SectionNumber">
					<xsl:value-of select="$sectionNumber"/>
				</span>
			</xsl:if>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</xsl:element>	
	</xsl:template>
	<xsl:template match="v3:text[not(parent::v3:observationMedia)]">
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates mode="mixed" select="node()"/>
		<xsl:apply-templates mode="rems" select="../v3:subject2[v3:substanceAdministration/v3:componentOf/v3:protocol]"/>
		<xsl:call-template name="flushfootnotes">
			<xsl:with-param name="isTableOfContent" select="'no'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="v3:observationMedia/v3:text" priority="2"/>

	<!-- DISPLAY SUBJECT STRUCTURED INFORMATION -->
	<xsl:template match="v3:excerpt|v3:subjectOf"/>

	<!-- PARAGRAPH MODEL -->
	<xsl:template match="v3:paragraph">
		<p>
			<xsl:if test="$root/v3:document[v3:code/@code = '3565717']">
				<xsl:attribute name="style">display: inline;</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode">
					<xsl:if test="count(preceding-sibling::v3:paragraph)=0">
						<xsl:text>First</xsl:text>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/> 
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<!-- see note anchoring and PCR 793 -->
			<!-- GS: moved this to after the styleCode and othe attribute handling -->
			<xsl:if test="@ID">
				<a name="{@ID}"/>
			</xsl:if>
			<xsl:apply-templates select="v3:caption"/>
			<xsl:apply-templates mode="mixed" select="node()[not(self::v3:caption)]"/>
		</p>
	</xsl:template>
	<xsl:template match="v3:paragraph/v3:caption">
		<span>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'ParagraphCaption'"/>
			</xsl:call-template>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</span>
	</xsl:template>
	<!-- the old poor man's footnote -->
	<xsl:template match="v3:paragraph[contains(@styleCode,'Footnote') and v3:caption]">
		<dl class="Footnote">
			<dt>
				<xsl:apply-templates mode="mixed" select="node()[self::v3:caption]"/>
			</dt>
			<dd>
				<xsl:apply-templates mode="mixed" select="node()[not(self::v3:caption)]"/>
			</dd>
		</dl>
	</xsl:template>
	<!-- LIST MODEL -->
	<!-- listType='unordered' is default, if any item has a caption,
			 all should have a caption -->
	<xsl:template match="v3:list[not(v3:item/v3:caption)]">
		<xsl:apply-templates select="v3:caption"/>
		<ul>
			<xsl:apply-templates select="@*|node()[not(self::v3:caption)]"/>
		</ul>
	</xsl:template>
	<xsl:template match="v3:list[@listType='ordered' and        not(v3:item/v3:caption)]" priority="1">
		<xsl:apply-templates select="v3:caption"/>
		<ol>
			<xsl:if test="$root/v3:document[v3:code/@code = '82351-8']">
				<xsl:attribute name="start">
					<xsl:value-of select="count(preceding-sibling::v3:list/v3:item) + 1"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*|node()[not(self::v3:caption)]"/>
		</ol>
	</xsl:template>
	<xsl:template match="v3:list/v3:item[not(parent::v3:list/v3:item/v3:caption)]">
		<li>
			<xsl:apply-templates select="@*"/>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</li> 
	</xsl:template>
	<!-- lists with custom captions -->
	<xsl:template match="v3:list[v3:item/v3:caption]">
		<xsl:apply-templates select="v3:caption"/>
		<dl>
			<xsl:apply-templates select="@*|node()[not(self::v3:caption)]"/>
		</dl>
	</xsl:template>
	<xsl:template match="v3:list/v3:item[parent::v3:list/v3:item/v3:caption]">
		<xsl:apply-templates select="v3:caption"/>
		<dd>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates mode="mixed" select="node()[not(self::v3:caption)]"/>
		</dd>
	</xsl:template>
	<xsl:template match="v3:list/v3:item/v3:caption">
		<dt>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</dt>
	</xsl:template>
	<xsl:template match="v3:list/v3:caption">
		<p>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'ListCaption'"/>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</p>
	</xsl:template>
	
	<!-- TABLE MODEL - the main table template has been moved to spl_canada.xsl, long with tr, td, and th -->
	<xsl:template match="v3:table/@summary|v3:table/@width|v3:table/@border|v3:table/@frame|v3:table/@rules|v3:table/@cellspacing|v3:table/@cellpadding">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:table/v3:caption">
		<caption>
			<xsl:apply-templates select="@*"/>
			<span>
				<xsl:apply-templates mode="mixed" select="node()"/>
			</span>
			<xsl:call-template name="additionalStyleAttr"/>
		</caption>
		<!--xsl:if test="not(preceding-sibling::v3:tfoot) and not(preceding-sibling::v3:tbody)">
				<xsl:call-template name="flushtablefootnotes"/>
				</xsl:if-->
	</xsl:template>
	<xsl:template match="v3:thead">
		<thead>
			<xsl:apply-templates select="@*|node()"/>
		</thead>
	</xsl:template>
	<xsl:template match="v3:thead/@align                       |v3:thead/@char                       |v3:thead/@charoff                       |v3:thead/@valign">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:tfoot" name="flushtablefootnotes">
		<xsl:variable name="allspan" select="count(ancestor::v3:table[1]/v3:colgroup/v3:col|ancestor::v3:table[1]/v3:col)"/>
		<xsl:if test="self::v3:tfoot or ancestor::v3:table[1]//v3:footnote">
			<tfoot>
				<xsl:if test="self::v3:tfoot">
					<xsl:apply-templates select="@*|node()"/>
				</xsl:if>
				<xsl:if test="ancestor::v3:table[1]//v3:footnote">
					<tr>
						<td colspan="{$allspan}" align="left">
							<dl class="Footnote">
								<xsl:apply-templates mode="footnote" select="ancestor::v3:table[1]/node()"/>				
							</dl>
						</td>
					</tr>
				</xsl:if>
			</tfoot>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v3:tfoot/@align                       |v3:tfoot/@char                       |v3:tfoot/@charoff                       |v3:tfoot/@valign">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:tbody">
		<xsl:if test="not(preceding-sibling::v3:tfoot) and not(preceding-sibling::v3:tbody)">
			<xsl:call-template name="flushtablefootnotes"/>
		</xsl:if>
		<tbody>
			<xsl:apply-templates select="@*|node()"/>
		</tbody>
	</xsl:template>
	<xsl:template match="v3:tbody[not(preceding-sibling::v3:thead)]">
		<xsl:if test="not(preceding-sibling::v3:tfoot) and not(preceding-sibling::tbody)">
			<xsl:call-template name="flushtablefootnotes"/>
		</xsl:if>
		<tbody>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Headless'"/>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates select="node()"/>
		</tbody>
	</xsl:template>
	<xsl:template match="v3:tbody/@align                       |v3:tbody/@char                       |v3:tbody/@charoff                       |v3:tbody/@valign">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:tr/@align|v3:tr/@char|v3:tr/@charoff|v3:tr/@valign">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:td/@align|v3:td/@char|v3:td/@charoff|v3:td/@valign|v3:td/@abbr|v3:td/@axis|v3:td/@headers|v3:td/@scope|v3:td/@rowspan|v3:td/@colspan">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:colgroup">
		<colgroup>
			<xsl:apply-templates select="@*|node()"/>
		</colgroup>
	</xsl:template>
	<xsl:template match="v3:colgroup/@span|v3:colgroup/@width|v3:colgroup/@align|v3:colgroup/@char|v3:colgroup/@charoff|v3:colgroup/@valign">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:col">
		<col>
			<xsl:apply-templates select="@*|node()"/>
		</col>
	</xsl:template>
	<xsl:template match="v3:col/@span|v3:col/@width|v3:col/@align|v3:col/@char|v3:col/@charoff|v3:col/@valign">
		<xsl:copy-of select="."/>
	</xsl:template>
	<!-- MIXED MODE: where text is rendered as is, even if nested 
			 inside elements that we do not understand  -->
	<!-- based on the deep null-transform -->
	<xsl:template mode="mixed" match="@*|node()">
		<xsl:apply-templates mode="mixed" select="@*|node()"/>
	</xsl:template>
	<xsl:template mode="mixed" match="text()" priority="0">
		<xsl:copy/>
	</xsl:template>
	<xsl:template mode="mixed" match="v3:content">
		<span>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCodeSequence" select="@emphasis|@revised"/>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/> 
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<!-- see note anchoring and PCR 793 -->
			<!-- GS: moved this till after styleCode and other attribute handling -->
			<xsl:choose>
				<xsl:when test="$root/v3:document[v3:code/@code = '82351-8']">
					<xsl:if test="not(@ID)">
						<xsl:apply-templates mode="mixed" select="node()"/>
					</xsl:if>
					<xsl:if test="@ID">
						<xsl:variable name="id" select="@ID"/>	
						<xsl:variable name="contentID" select="concat('#',$id)"/>
						<xsl:variable name="link" select="/v3:document//v3:subject/v3:manufacturedProduct/v3:subjectOf/v3:document[v3:title/v3:reference/@value = $contentID]/v3:text/v3:reference/@value"/>
						<xsl:if test="$link">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="$link"/>
								</xsl:attribute>
								<xsl:apply-templates mode="mixed" select="node()"/>		
							</a>
						</xsl:if>
						<xsl:if test="not($link)">
							<a name="{@ID}"/>
							<xsl:apply-templates mode="mixed" select="node()"/>	
						</xsl:if>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="@ID">
						<a name="{@ID}"/>
					</xsl:if>
					<xsl:apply-templates mode="mixed" select="node()"/>
				</xsl:otherwise>
			</xsl:choose>	
		</span>
	</xsl:template>
	<xsl:template mode="mixed" match="v3:content[@emphasis='yes']" priority="1">
		<em>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCodeSequence" select="@revised"/>
			</xsl:call-template>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</em>
	</xsl:template>
	<xsl:template mode="mixed" match="v3:content[@emphasis]">
		<em>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCodeSequence" select="@emphasis|@revised"/>
			</xsl:call-template>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</em>
	</xsl:template>
	<!-- We don't use <sub> and <sup> elements here because IE produces
			 ugly uneven line spacing. -->
	<xsl:template mode="mixed" match="v3:sub">
		<span>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Sub'"/>
			</xsl:call-template>
			<xsl:apply-templates mode="mixed" select="@*|node()"/>
		</span>
	</xsl:template>
	<xsl:template mode="mixed" match="v3:sup">
		<span>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Sup'"/>
			</xsl:call-template>
			<xsl:apply-templates mode="mixed" select="@*|node()"/>
		</span>
	</xsl:template>
	<xsl:template mode="mixed" match="v3:br">
		<br/>
	</xsl:template>
	<xsl:template mode="mixed" priority="1" match="v3:renderMultiMedia[@referencedObject and (ancestor::v3:paragraph or ancestor::v3:td or ancestor::v3:th)]">
		<xsl:variable name="reference" select="@referencedObject"/>
		<!-- see note anchoring and PCR 793 -->
		<xsl:if test="@ID">
			<a name="{@ID}"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="boolean(//v3:observationMedia[@ID=$reference]//v3:text)">
				<img alt="{//v3:observationMedia[@ID=$reference]//v3:text}" src="{//v3:observationMedia[@ID=$reference]//v3:reference/@value}">
					<xsl:apply-templates select="@*"/>
				</img>
			</xsl:when>
			<xsl:when test="not(boolean(//v3:observationMedia[@ID=$reference]//v3:text))">
				<img alt="Image from Drug Label Content" src="{//v3:observationMedia[@ID=$reference]//v3:reference/@value}">
					<xsl:apply-templates select="@*"/>
				</img>
			</xsl:when>
		</xsl:choose>
		<xsl:apply-templates mode="notCentered" select="v3:caption"/>
	</xsl:template>
	<xsl:template mode="mixed" match="v3:renderMultiMedia[@referencedObject]">
		<xsl:variable name="reference" select="@referencedObject"/>
		<div>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Figure'"/>
			</xsl:call-template>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>

			<!-- see note anchoring and PCR 793 -->
			<xsl:if test="@ID">
				<a name="{@ID}"/>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="boolean(//v3:observationMedia[@ID=$reference]//v3:text)">
					<img alt="{//v3:observationMedia[@ID=$reference]//v3:text}" src="{//v3:observationMedia[@ID=$reference]//v3:reference/@value}">
						<xsl:apply-templates select="@*"/>
					</img>
				</xsl:when>
				<xsl:when test="not(boolean(//v3:observationMedia[@ID=$reference]//v3:text))">
					<img alt="Image from Drug Label Content" src="{//v3:observationMedia[@ID=$reference]//v3:reference/@value}">
						<xsl:apply-templates select="@*"/>
					</img>
				</xsl:when>
			</xsl:choose>			
			<xsl:apply-templates select="v3:caption"/>
		</div>
	</xsl:template>
	<xsl:template match="v3:renderMultiMedia/v3:caption">
		<p>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" 
												select="'MultiMediaCaption'"/>
			</xsl:call-template>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</p>
	</xsl:template>
	<xsl:template mode="notCentered" match="v3:renderMultiMedia/v3:caption">
		<p>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'MultiMediaCaptionNotCentered'"/>
			</xsl:call-template>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</p>
	</xsl:template>
	<xsl:template mode="mixed" match="v3:paragraph|v3:list|v3:table|v3:footnote|v3:footnoteRef|v3:flushfootnotes">
		<xsl:param name="isTableOfContent"/>
		<xsl:choose>
			<xsl:when test="$isTableOfContent='yes'">
				<xsl:apply-templates select=".">
					<xsl:with-param name="isTableOfContent2" select="'yes'"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select=".">
					<xsl:with-param name="isTableOfContent2" select="'no'"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- MODE: DATA - deep null transform -->
	<xsl:template mode="data" match="*">
		<xsl:apply-templates mode="data" select="node()"/>
	</xsl:template>
	<xsl:template mode="data" match="text()">
		<xsl:copy/>
	</xsl:template>
	<xsl:template mode="data" match="*[@displayName and not(@code)]">
		<xsl:value-of select="@displayName"/>
	</xsl:template>
	<xsl:template mode="data" match="*[not(@displayName) and @code]">
		<xsl:value-of select="@code"/>
	</xsl:template>
	<xsl:template mode="data" match="*[@displayName and @code]">
		<xsl:value-of select="@displayName"/>
		<xsl:text> (</xsl:text>
		<xsl:value-of select="@code"/>
		<xsl:text>)</xsl:text>
	</xsl:template>
	<!-- add by Brian Suggs on 11-14-05. This will take care of the characteristic unit attribute that wasn't before taken care of -->
	<xsl:template mode="data" match="*[@value and @unit]" priority="1">
		<xsl:value-of select="@value"/>&#160;<xsl:value-of select="@unit"/>
	</xsl:template>
	<xsl:template mode="data" match="*[@value and not(@displayName)]">
		<xsl:value-of select="@value"/>
	</xsl:template>
	<xsl:template mode="data" match="*[@value and @displayName]">
		<xsl:value-of select="@value"/>
		<xsl:text>&#160;</xsl:text>
		<xsl:value-of select="@displayName"/>
	</xsl:template>
	<xsl:template mode="data" match="*[@value and (@xsi:type='TS' or contains(local-name(),'Time'))]" priority="1">
		<xsl:param name="displayMonth">true</xsl:param>
		<xsl:param name="displayDay">true</xsl:param>
		<xsl:param name="displayYear">true</xsl:param>
		<xsl:param name="delimiter">/</xsl:param>
		<xsl:variable name="year" select="substring(@value,1,4)"/>
		<xsl:variable name="month" select="substring(@value,5,2)"/>
		<xsl:variable name="day" select="substring(@value,7,2)"/>
		<!-- changed by Brian Suggs 11-13-05.  Changes made to display date in MM/DD/YYYY format instead of DD/MM/YYYY format -->
		<xsl:if test="$displayMonth = 'true'">
			<xsl:choose>
				<xsl:when test="starts-with($month,'0')">
					<xsl:value-of select="substring-after($month,'0')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$month"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$delimiter"/>
		</xsl:if>
		<xsl:if test="$displayDay = 'true'">
			<xsl:value-of select="$day"/>
			<xsl:value-of select="$delimiter"/>
		</xsl:if>
		<xsl:if test="$displayYear = 'true'">
			<xsl:value-of select="$year"/>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="data" match="*[v3:numerator]">
		<xsl:apply-templates mode="data" select="v3:numerator"/>
		<xsl:if test="v3:denominator[not(@value='1' and (not(@unit) or @unit='1'))]">
			<xsl:text> : </xsl:text>
			<xsl:apply-templates mode="data" select="v3:denominator"/>
		</xsl:if>
	</xsl:template>
	<!-- pmh canada uses simplified Effective Date -->
	<!-- block at sections unless handled specially -->
	<xsl:template mode="data" match="v3:section"/>
	<!-- This section will display all of the subject information in one easy to read table. This view is replacing the previous display of the data elements. -->
	<xsl:template mode="subjects" match="/|@*|node()">
		<xsl:apply-templates mode="subjects" select="@*|node()"/>
	</xsl:template>
	<xsl:template mode="subjects" match="v3:section[v3:code/@code ='48780-1'][not(v3:subject/v3:manufacturedProduct)]/v3:text">
		<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%">
			<tbody>
				<xsl:call-template name="ProductInfoBasic"/>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="equivalentProductInfo">
		<tr>
			<td>
				<table style="font-size:100%"  width="100%"  cellpadding="3" cellspacing="0" class="contentTablePetite">
					<tbody>
						<tr>
							<th align="left" class="formHeadingTitle">
								<xsl:choose>
									<xsl:when test="v3:ingredient">
										<strong><xsl:text>Abstract Product Concept</xsl:text></strong>
									</xsl:when>
									<xsl:otherwise>
										<strong><xsl:text>Application Product Concept</xsl:text></strong>
									</xsl:otherwise>
								</xsl:choose>
							</th>
						</tr>
							<xsl:call-template name="ProductInfoBasic"/>
						<tr>
							<td>
								<xsl:call-template name="ProductInfoIng"></xsl:call-template>
							</td>
						</tr>
						<tr>
							<td  class="normalizer">
								<xsl:call-template name="MarketingInfo"></xsl:call-template>
							</td>
						</tr>
						<xsl:variable name="currCode" select="v3:code/@code"></xsl:variable>
						<xsl:for-each select="ancestor::v3:section[1]/v3:subject/v3:manufacturedProduct/v3:manufacturedProduct[v3:asEquivalentEntity/v3:definingMaterialKind/v3:code[not(@code = ../../../v3:code/@code)]/@code = $currCode]">
							<xsl:call-template name="equivalentProductInfo"></xsl:call-template>
						</xsl:for-each>
					</tbody>
				</table>
			</td>
		</tr>
	</xsl:template>

	<!-- XXX: named templates, really not a good idea, but we can't fix the mess all at once 
			 These used to be sometimes incompletely defined modes with templates matching everything, leading to default template messes.
			 Now they are all named templates that are to be invoked in exactly one context.
			 Usually any of these templates are to be invoked in the product entity context, that way we avoid so many navigation choices
			 to get to role information and additional information it is easier to just step up.
	-->
	<!-- Templates for Medication Name have been overridden in spl_canada.xsl -->
	
	<xsl:template name="ProductInfoIng">		
		<xsl:if test="v3:ingredient[starts-with(@classCode,'ACTI')]|v3:activeIngredient">
			<tr>
				<td>
					<xsl:call-template name="ActiveIngredients"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="v3:ingredient[@classCode = 'IACT']|v3:inactiveIngredient">
			<tr>
				<td>
					<xsl:call-template name="InactiveIngredients"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="v3:ingredient[not(@classCode='IACT' or starts-with(@classCode,'ACTI'))]">
			<tr>
				<td>
					<xsl:call-template name="otherIngredients"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="not($root/v3:document/v3:code/@code = '58476-3')">
			<tr>
				<td>
					<xsl:choose>
						<xsl:when test="v3:asEntityWithGeneric and ../v3:subjectOf/v3:characteristic/v3:code[starts-with(@code, 'SPL')]">
							<xsl:call-template name="characteristics-old"/>
						</xsl:when>
						<xsl:when test="../v3:subjectOf/v3:characteristic">
							<xsl:call-template name="characteristics-new"/>
						</xsl:when>
					</xsl:choose>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="v3:asContent">
			<tr>
				<td>
					<xsl:call-template name="packaging">
						<xsl:with-param name="path" select="."/>
					</xsl:call-template>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="v3:instanceOfKind[parent::v3:partProduct]">
			<tr>
				<td colspan="4">
					<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
						<xsl:apply-templates mode="ldd" select="v3:instanceOfKind"/>
					</table>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>	
	
	<!-- Templates for Active and Inactive Ingredients have been overridden in spl_canada.xsl -->
	<!-- Templates for Other Ingredients is left here even though it is currently unused -->
	<xsl:template name="otherIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="3" class="formHeadingTitle">
					<xsl:if test="v3:ingredient[@classCode = 'INGR' or starts-with(@classCode,'ACTI')]">Other </xsl:if>
					<xsl:text>Ingredients</xsl:text>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">Ingredient Kind</th>
				<th class="formTitle" scope="col">Ingredient Name</th>
				<th class="formTitle" scope="col">Quantity</th>
			</tr>
			<xsl:for-each select="v3:ingredient[not(@classCode='IACT' or starts-with(@classCode,'ACTI'))]">
				<tr>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
							<xsl:otherwise>formTableRowAlt</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<td class="formItem">
						<xsl:choose>
							<xsl:when test="@classCode = 'BASE'">Base</xsl:when>
							<xsl:when test="@classCode = 'ADTV'">Additive</xsl:when>
							<xsl:when test="@classCode = 'CNTM' and v3:quantity/v3:numerator/@value='0'">Does not contain</xsl:when>
							<xsl:when test="@classCode = 'CNTM'">May contain</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@classCode"/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<xsl:for-each select="(v3:ingredientSubstance|v3:activeIngredientSubstance)[1]">
						<td class="formItem">
							<strong>
								<xsl:value-of select="v3:name"/>
							</strong>
							<xsl:text> (</xsl:text>
							<xsl:for-each select="v3:code/@code">
								<xsl:text>UNII: </xsl:text>
								<xsl:value-of select="."/>
							</xsl:for-each>
							<xsl:text>) </xsl:text>
							<xsl:if test="normalize-space(v3:ingredientSubstance/v3:activeMoiety/v3:activeMoiety/v3:name)"> (<xsl:value-of
							select="v3:ingredientSubstance/v3:activeMoiety/v3:activeMoiety/v3:name"/>) </xsl:if>
						</td>
					</xsl:for-each>
					<td class="formItem">
						<xsl:value-of select="v3:quantity/v3:numerator/@value"/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:numerator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:numerator/@unit"/></xsl:if>
						<xsl:if test="v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@unit)!='1'"> &#160;in&#160;<xsl:value-of select="v3:quantity/v3:denominator/@value"
						/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/>
							</xsl:if></xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<!-- All of the characteristics using FDA controlled vocabulary have been simplified and moved to spl_canada.xsl -->
	<!-- We could do something similar to this in spl_canada.xsl, based on xsi:type, but have not:
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'ST']">
		<td class="formItem" colspan="2"><xsl:value-of select="text()"/></td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'BL']">
		<td class="formItem" colspan="2"><xsl:value-of select="@value"/></td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'PQ']">
		<td class="formItem"><xsl:value-of select="@value"/></td>
		<td class="formItem"><xsl:value-of select="@unit"/></td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'INT']">
		<td class="formItem"><xsl:value-of select="@value"/></td>
		<td class="formItem"/>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'CV' or @xsi:type = 'CE' or @xsi:type = 'CE']">
		<td class="formItem">
			<xsl:value-of select=".//@displayName[1]"/>
		</td>
		<td class="formItem">
			<xsl:value-of select=".//@code[1]"/>
		</td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'REAL']">
		<td class="formItem"><xsl:value-of select="@value"/></td>
		<td class="formItem"/>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'IVL_PQ' and v3:high/@unit = v3:low/@unit]" priority="2">
		<td class="formItem">
			<xsl:value-of select="v3:low/@value"/>
			<xsl:text>-</xsl:text>
			<xsl:value-of select="v3:high/@value"/>
		</td>
		<td><xsl:value-of select="v3:low/@unit"/></td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'IVL_PQ' and v3:high/@value and not(v3:low/@value)]">
		<td class="formItem">
			<xsl:text>&lt;</xsl:text>
			<xsl:value-of select="v3:high/@value"/>
		</td>
		<td class="formItem"><xsl:value-of select="v3:high/@unit"/></td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'IVL_PQ' and v3:low/@value and not(v3:high/@value)]">
		<td class="formItem">
			<xsl:text>></xsl:text>
		<xsl:value-of select="v3:low/@value"/>
	</td>
	<td class="formItem"><xsl:value-of select="v3:low/@unit"/></td>
</xsl:template> -->
<xsl:template name="image">
	<xsl:param name="path" select="."/>
	<xsl:if test="string-length($path/v3:value/v3:reference/@value) > 0">
		<img alt="Image of Product" style="width:100%;" src="{$path/v3:value/v3:reference/@value}"/>
	</xsl:if>
</xsl:template>
	
<!-- Templates for Package Info overridden in spl_canada.xsl -->
<!-- Templates for Marketing Info have been overriden in spl_canada -->
<!-- Templates for Supplier and Distributor Contact Info have been overridden in spl_canada.xsl: -->
<!-- Removed all templates for ldd and fill/bulk/label -->
<!-- Removed older templating for Establishment/Organization -->
<!-- Removed PLRIndications template -->
<!-- Removed Indications, Display Conditions of Use and Display Conditions of Use -->
<!-- Removed Interactions template -->
<!-- Removed Adverse Reactions template -->
<!-- Removed Other Indication template -->
<!-- Removed Pharmacological Class template -->

</xsl:transform>