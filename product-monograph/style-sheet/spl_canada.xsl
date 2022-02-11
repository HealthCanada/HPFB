<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:v3="urn:hl7-org:v3" xmlns:str="http://exslt.org/strings" 
	xmlns:exsl="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" 
	exclude-result-prefixes="exsl msxsl v3 gc xsl xsi str">
	<xsl:import href="spl_common.xsl"/>
	<xsl:import href="spl_canada_screen.xsl"/>
	<xsl:import href="spl_canada_i18n.xsl"/>
	
	<!-- Retaining all of these unused parameters for future use -->
	<!-- Whether to show the clickable XML, set to "/.." instead of "1" to turn off -->
	<xsl:param name="show-subjects-xml" select="/.."/>
	<!-- Whether to show the data elements in special tables etc., set to "/.." instead of "1" to turn off -->
	<xsl:param name="show-data" select="/.."/>
	<!-- Whether to show section numbers, set to 1 to enable and "/.." to turn off -->
	<xsl:param name="show-section-numbers" select="/.."/>
	<!-- Whether to show print table of contents, set to 1 to enable and "/.." to turn off -->
	<xsl:param name="show-print-toc" select="/.."/>
	<!-- Whether to show jump to top button, set to 1 to enable and "/.." to turn off -->
	<xsl:param name="show-jump-to-top" select="/.."/>
	<xsl:param name="show-review-section" select="/.."/>
	<xsl:param name="use-wet-boew-headers" select="/.."/>
	<!-- This is the CSS link put into the output -->
	<xsl:param name="css">https://healthcanada.github.io/HPFB/product-monograph/style-sheet/spl_canada.css</xsl:param>
	<!-- This is the HTML Document Title -->
	<xsl:param name="doc-title"><xsl:value-of select="v3:document/v3:title"/></xsl:param>
	<!-- This is to replace relative image paths with absolute paths -->
	<xsl:param name="base-uri"></xsl:param>
	
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="v3:document/v3:languageCode[@code='1']">en</xsl:when>
			<xsl:when test="v3:document/v3:languageCode[@code='2']">fr</xsl:when>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:output method="html" version="5" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no" />
<!--	<xsl:output method="html" version="5" encoding="utf-8" indent="yes" /> -->
	
	<!-- OVERRIDE FDA STYLES FOR MANUFACTURED PRODUCT DETAILS - SUBJECTS MODE -->	
	<!-- Override FDA company info section, using Canadian French and English labels -->
	<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization">	
		<xsl:if test="(count(./v3:name)>0)">
			<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
			<table cellpadding="3" cellspacing="0" class="formTableMorePetite fullWidth">
				<tr>
					<td colspan="2" class="formHeadingReg">
						<span class="formHeadingTitle"><xsl:value-of select="$labels/labeler[@lang = $lang]"/> -&#160;</span>
						<xsl:value-of select="./v3:name"/> 
						<xsl:if test="./v3:id/@extension"> (<xsl:value-of select="./v3:id/@extension"/>)</xsl:if>
					</td>
				</tr>
				<xsl:apply-templates mode="subjects" select="v3:contactParty"/>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization">	
		<xsl:if test="./v3:name">
			<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
			<table cellpadding="3" cellspacing="0" class="formTableMorePetite fullWidth">
				<tr>
					<td colspan="2" class="formHeadingReg">
						<span class="formHeadingTitle"><xsl:value-of select="$labels/registrant[@lang = $lang]"/> -&#160;</span>
						<xsl:value-of select="./v3:name"/>
						<xsl:if test="./v3:id/@extension"> (<xsl:value-of select="./v3:id/@extension"/>)</xsl:if>
					</td>
				</tr>
				<xsl:apply-templates mode="subjects" select="v3:contactParty"/>
			</table>
		</xsl:if>
	</xsl:template>	

	<xsl:template mode="subjects" match="v3:contactParty">
		<xsl:if test="position() = 1">
			<tr>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/partyAddress[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/partyAdditional[@lang = $lang]"/></th>
			</tr>
		</xsl:if>
		<tr class="formTableRowAlt">
			<td class="formItem Padded">
				<xsl:value-of select="v3:addr/v3:streetAddressLine"/>
				<br/>
				<xsl:value-of select="v3:addr/v3:city"/>
				<xsl:if test="string-length(v3:addr/v3:state)>0">,&#160;<xsl:value-of select="v3:addr/v3:state"/></xsl:if>
				<xsl:if test="string-length(v3:addr/v3:postalCode)>0">,&#160;<xsl:value-of select="v3:addr/v3:postalCode"/></xsl:if>
				<br/>
				<xsl:value-of select="v3:addr/v3:country/@displayName"/>					
			</td>
			<td class="formItem Padded">
				<xsl:value-of select="$labels/partyTel[@lang = $lang]"/><xsl:text>: </xsl:text>
				<xsl:value-of select="substring-after(v3:telecom/@value[starts-with(.,'tel:')][1], 'tel:')"/>
				<br/>
				<xsl:for-each select="v3:telecom/@value[starts-with(.,'fax:')]">
					<xsl:text>Fax: </xsl:text>
					<xsl:value-of select="substring-after(., 'fax:')"/>
					<br/>
				</xsl:for-each>
				<xsl:for-each select="v3:telecom/@value[starts-with(.,'mailto:')]">
					<xsl:value-of select="$labels/partyEmail[@lang = $lang]"/><xsl:text>: </xsl:text>
st					<a>
						<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
						<xsl:value-of select="substring-after(., 'mailto:')"/>
					</a>
					<br/>
				</xsl:for-each>
				<xsl:for-each select="v3:telecom/@value[starts-with(.,'http:') or starts-with(.,'https:')]">
					<xsl:value-of select="$labels/partyWeb[@lang = $lang]"/><xsl:text>: </xsl:text>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
						<xsl:value-of select="."/>
					</a>
					<br/>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>	

	<!-- Note: This template is also used for top level Product Concept which does not have v3:asEquivalentEntity -->
	<!-- Canada does not currently require equivalent or abstract product concept -->
	<xsl:template mode="subjects" match="v3:section/v3:subject/v3:manufacturedProduct/*[self::v3:manufacturedProduct[v3:name or v3:formCode] or self::v3:manufacturedMedicine][not(v3:asEquivalentEntity/v3:definingMaterialKind[/v3:document/v3:code/@code = '73815-3'])]|v3:section/v3:subject/v3:identifiedSubstance/v3:identifiedSubstance">
		<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
		<table class="contentTablePetite fullWidth" cellSpacing="0" cellPadding="3">
			<tbody>
				<xsl:call-template name="piMedNames"/>
				<xsl:apply-templates mode="substance" select="v3:moiety"/>
				<xsl:call-template name="ProductInfoBasic"/>				
				<xsl:choose>
					<!-- if this is a multi-component subject then call to parts template, and display Product Status from within this template -->
					<xsl:when test="v3:part">
						<xsl:apply-templates mode="subjects" select="v3:part"/>
					</xsl:when>
					<!-- otherwise it is a single product and we simply need to display the ingredients, imprint and packaging. -->
					<!-- in this case, the Product Status is between Product Info and Ingredients, with Packaging Status at the bottom -->
					<xsl:otherwise>
						<xsl:call-template name="ProductInfoIng"/>
						<xsl:call-template name="MarketingInfo"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="v3:instanceOfKind">
					<tr>
						<td colspan="4">
							<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
							<table cellpadding="3" cellspacing="0" class="formTablePetite fullWidth">
								<xsl:apply-templates mode="ldd" select="v3:instanceOfKind"/>
							</table>
						</td>
					</tr>
				</xsl:if>				
			</tbody>
		</table>
	</xsl:template>
	
	<!-- Override FDA Product Info section, using Canadian French and English labels - note, we could drop the Alt class, since we are not using row banding -->
	<xsl:template name="ProductInfoBasic">
		<tr>
			<td>
				<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
				<table cellpadding="3" cellspacing="0" class="formTablePetite fullWidth">
					<!-- [pmh WS_PM-028/029] replace the top row with a caption, use th for vertical headers, and remove banding on alternate rows -->
					<caption class="formHeadingTitle">
						<xsl:value-of select="$labels/productInfo[@lang = $lang]"/>
					</caption>
					<tr class="formTableRow">
						<th class="formLabel"> <!-- Product Brand Name -->
							<xsl:value-of select="$labels/brandName[@lang = $lang]"/>
						</th>
						<td class="formItem"><xsl:value-of select="v3:name"/></td>
					</tr>
					<tr class="formTableRow">
						<th class="formLabel"> <!-- Product Generic Name -->
							<xsl:value-of select="$labels/nonPropName[@lang = $lang]"/>
						</th>
						<td class="formItem"><xsl:value-of select="v3:asEntityWithGeneric/v3:genericMedicine/v3:name"/></td>
					</tr>
					<tr class="formTableRow">
						<th class="formLabel"> <!-- Product DIN -->
							<xsl:value-of select="$labels/din[@lang = $lang]"/>
						</th>
						<td class="formItem"><xsl:value-of select="v3:code/@code"/></td>
					</tr>
					<tr class="formTableRow">
						<th class="formLabel"> <!-- Product Substance Administration Route -->
							<xsl:value-of select="$labels/adminRoute[@lang = $lang]"/>
						</th>
						<td class="formItem"> <!-- may have multiple supported administration routes -->
							<xsl:for-each select="../v3:consumedIn/v3:substanceAdministration/v3:routeCode">
								<xsl:value-of select="@displayName"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</td>
					</tr>
					<tr class="formTableRow">
						<th class="formLabel"> <!-- Product Dosage Form - withhold display name if the form code indicates a 'kit' -->
							<xsl:value-of select="$labels/dosageForm[@lang = $lang]"/>
						</th>
						<td class="formItem">
							<xsl:if test="not((v3:formCode/@code='C43197') and (v3:formCode/@codeSystem='2.16.840.1.113883.2.20.6.3'))">
								<xsl:value-of select="v3:formCode/@displayName"/>
							</xsl:if>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>
	
	<!-- Override FDA Medication Names in order to withhold Medication Form Code 'Kit' -->
	<xsl:template name="piMedNames">
		<xsl:variable name="medName">
			<xsl:call-template name="string-uppercase">
				<xsl:with-param name="text">
					<xsl:copy><xsl:apply-templates mode="specialCus" select="v3:name" /></xsl:copy>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="genMedName">
			<xsl:call-template name="string-uppercase">
				<xsl:with-param name="text" select="v3:asEntityWithGeneric/v3:genericMedicine/v3:name|v3:asSpecializedKind/v3:generalizedMaterialKind/v3:code[@codeSystem = '2.16.840.1.113883.6.276'  or @codeSystem = '2.16.840.1.113883.6.303']/@displayName"/>
			</xsl:call-template>
		</xsl:variable>		
		
		<!-- [pmh WS_PM-028] use caption instead of the first header row -->
		<caption class="contentTableTitle">
			<strong>
				<xsl:value-of select="$medName"/>&#160;		
				<xsl:call-template name="string-uppercase">
					<xsl:with-param name="text" select="v3:name/v3:suffix"/>
				</xsl:call-template>	
			</strong>
			<xsl:apply-templates mode="substance" select="v3:code[@codeSystem = '2.16.840.1.113883.4.9']/@code"/>
			<xsl:if test="not($root/v3:document/v3:code/@code = '73815-3')">
				<br/>
			</xsl:if>	
			<span class="contentTableReg">
				<xsl:call-template name="string-lowercase">
					<xsl:with-param name="text" select="$genMedName"/>
				</xsl:call-template>
				<xsl:if test="not((v3:formCode/@code='C43197') and (v3:formCode/@codeSystem='2.16.840.1.113883.2.20.6.3'))">
					<xsl:text> </xsl:text>
					<xsl:call-template name="string-lowercase">
						<xsl:with-param name="text" select="v3:formCode/@displayName"/>
					</xsl:call-template>
				</xsl:if>
			</span>
		</caption>
	</xsl:template>
	
	<xsl:template name="ProductInfoIng">		
		<tr>
			<td>
				<table cellpadding="3" cellspacing="0" class="formTablePetite fullWidth">
					<caption class="formHeadingTitle">
						<xsl:value-of select="$labels/composition[@lang = $lang]"/>
					</caption>
					<xsl:if test="v3:ingredient[starts-with(@classCode,'ACTI')]|v3:activeIngredient">
						<xsl:call-template name="ActiveIngredients"/>
					</xsl:if>
					<xsl:if test="v3:ingredient[@classCode = 'IACT']|v3:inactiveIngredient">
						<xsl:call-template name="InactiveIngredients">
							<xsl:with-param name="show-strength" select="not(v3:ingredient[starts-with(@classCode,'ACTI')]|v3:activeIngredient)"/>
						</xsl:call-template>
					</xsl:if>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:call-template name="characteristics-old"/>
			</td>
		</tr>
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
					<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
					<table cellpadding="3" cellspacing="0" class="formTablePetite fullWidth">
						<xsl:apply-templates mode="ldd" select="v3:instanceOfKind"/>
					</table>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>

	<!-- [pmh #93] Moved format-physical-quantity to spl_canada_i18n.xsl, since rendering is different for French and English values -->
	<!-- Extra logic required for URG_PQ Active Ingredients and formatting the Physical Quantity to add commas for thousands -->
	<xsl:template match="v3:quantity/v3:numerator">
		<xsl:choose>
			<xsl:when test="v3:low and v3:high">
				<xsl:apply-templates select="v3:low/@value" mode="format-physical-quantity"/>					
				<xsl:value-of select="$labels/toConnective[@lang = $lang]"/>
				<xsl:apply-templates select="v3:high/@value" mode="format-physical-quantity"/>&#160;								
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="@value" mode="format-physical-quantity"/>&#160;								
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="v3:low/@unit">
				<xsl:value-of select="v3:low/@unit"/>
			</xsl:when>
			<xsl:when test="v3:high/@unit">
				<xsl:value-of select="v3:high/@unit"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@unit"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Templating for Active Ingredient Basis of Strength -->
	<xsl:template match="v3:code" mode="active-ingredient-bos">
		<xsl:value-of select="@displayName"/>
		<xsl:text> (</xsl:text>
			<xsl:value-of select="@code"/>
		<xsl:text>) </xsl:text>		
	</xsl:template>
		
	<!-- Display the ingredient information (both active and inactive) -->
	<xsl:template name="ActiveIngredients">
		<tr>
			<th class="formTitle" scope="col">
				<xsl:value-of select="$labels/activeIngredients[@lang = $lang]"/>
			</th>
			<th class="formTitle" scope="col">
				<xsl:value-of select="$labels/activeMoieties[@lang = $lang]"/>
			</th>
			<th class="formTitle" scope="col">
				<xsl:value-of select="$labels/basisOfStrength[@lang = $lang]"/>
			</th>
			<th class="formTitle" scope="col">
				<xsl:value-of select="$labels/strength[@lang = $lang]"/>
			</th>
		</tr>		
		
		<xsl:for-each select="v3:ingredient[starts-with(@classCode, 'ACTI')]|v3:activeIngredient">
			<tr>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
						<xsl:otherwise>formTableRowAlt</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:for-each select="(v3:ingredientSubstance|v3:activeIngredientSubstance)[1]">
					<td class="formItem">
						<strong>
							<xsl:value-of select="v3:code/@displayName"/>
						</strong>
						<xsl:text> (</xsl:text>
						<xsl:for-each select="v3:code/@code">
							<xsl:value-of select="."/>
							<xsl:if test="position()!=last()"><xsl:value-of select="$labels/andConnective[@lang = $lang]"/></xsl:if>
						</xsl:for-each>
						<xsl:text>) </xsl:text>
					</td>
					<td class="formItem">
						<xsl:if test="normalize-space(v3:activeMoiety/v3:activeMoiety/v3:code/@displayName)">
							<xsl:for-each select="v3:activeMoiety/v3:activeMoiety/v3:code">
								<xsl:value-of select="@displayName"/>
								<xsl:text> (</xsl:text>
								<xsl:value-of select="@code"/>
								<xsl:text>) </xsl:text>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</xsl:if>
					</td>
					<td class="formItem">
						<xsl:choose>
							<xsl:when test="../@classCode='ACTIR'">
								<xsl:apply-templates select="v3:asEquivalentSubstance/v3:definingSubstance/v3:code" mode="active-ingredient-bos"/>
							</xsl:when>
							<xsl:when test="../@classCode='ACTIB'">
								<xsl:apply-templates select="v3:code" mode="active-ingredient-bos"/>
							</xsl:when>
							<xsl:when test="../@classCode='ACTIM'">
								<xsl:apply-templates select="v3:activeMoiety/v3:activeMoiety/v3:code" mode="active-ingredient-bos"/>
							</xsl:when>
						</xsl:choose>
					</td>
				</xsl:for-each>
				<td class="formItem">
					<xsl:apply-templates select="v3:quantity/v3:numerator"/>
					<xsl:if test="(v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@value)!='1') 
												or (v3:quantity/v3:denominator/@unit and normalize-space(v3:quantity/v3:denominator/@unit)!='1')"> <xsl:value-of select="$labels/inConnective[@lang = $lang]"/><xsl:value-of select="v3:quantity/v3:denominator/@value"/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/>
					</xsl:if></xsl:if>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="InactiveIngredients">
		<xsl:param name="show-strength" select="false()"/>
		<tr>
			<th class="formTitle" scope="col" colspan="3">
				<xsl:value-of select="$labels/inactiveIngredients[@lang = $lang]"/>						
			</th>
			<th class="formTitle" scope="col">
				<xsl:if test="$show-strength">
					<xsl:value-of select="$labels/strength[@lang = $lang]"/>					
				</xsl:if>
			</th>
		</tr>		
		<xsl:for-each select="v3:ingredient[@classCode='IACT']|v3:inactiveIngredient">
			<tr>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
						<xsl:otherwise>formTableRowAlt</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:for-each select="(v3:ingredientSubstance|v3:inactiveIngredientSubstance)[1]">
					<td class="formItem" colspan="3">
						<xsl:for-each select="v3:code">
							<strong><xsl:value-of select="@displayName"/></strong>								
							<xsl:text> (</xsl:text>
								<xsl:value-of select="@code"/>
							<xsl:text>) </xsl:text>
							<xsl:if test="position()!=last()"><xsl:value-of select="$labels/andConnective[@lang = $lang]"/></xsl:if>
						</xsl:for-each>
					</td>
				</xsl:for-each>
				<td class="formItem">
					<xsl:value-of select="v3:quantity/v3:numerator/@value"/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:numerator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:numerator/@unit"/></xsl:if>
					<xsl:if test="v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@unit)!='1'"> <xsl:value-of select="$labels/inConnective[@lang = $lang]"/><xsl:value-of select="v3:quantity/v3:denominator/@value"
					/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/>
						</xsl:if></xsl:if>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<!-- Product Characteristics now use simplified templating -->
	<xsl:template name="characteristics-new">
		<xsl:call-template name="characteristics-old"/>
	</xsl:template>

	<xsl:template name="codedCharacteristicRow">
		<xsl:param name="path" select="."/>
		<xsl:param name="class">formTableRow</xsl:param>
		<xsl:param name="label"><xsl:value-of select="$path/v3:code/@displayName"/></xsl:param>
		<tr class="{$class}">
			<td class="formLabel">
				<xsl:value-of select="$label"/>
			</td>
			<td class="formItem">
				<xsl:value-of select="$path/v3:value/@displayName"/>
			</td>
		</tr>
	</xsl:template>

	<!-- [pmh WS_PM-029] use th instead of td for vertical characteristic headings -->
	<xsl:template name="stringCharacteristicRow">
		<xsl:param name="path" select="."/>
		<xsl:param name="class">formTableRow</xsl:param>
		<xsl:param name="label"><xsl:value-of select="$path/v3:code/@displayName"/></xsl:param>
		<tr class="{$class}">
			<th class="formLabel">
				<xsl:value-of select="$label"/>
			</th>
			<td class="formItem">
				<xsl:value-of select="$path/v3:value[@xsi:type='ST']/text()"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="pqCharacteristicRow">
		<xsl:param name="path" select="."/>
		<xsl:param name="class">formTableRow</xsl:param>
		<xsl:param name="label"><xsl:value-of select="$path/v3:code/@displayName"/></xsl:param>
		<tr class="{$class}">
			<th class="formLabel">
				<xsl:value-of select="$label"/>
			</th>
			<td class="formItem">
				<xsl:value-of select="$path/v3:value/@value"/>
				<xsl:value-of select="$path/v3:value/@unit"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template name="listedCharacteristicRow">
		<xsl:param name="path" select="."/>
		<xsl:param name="class">formTableRow</xsl:param>
		<xsl:param name="label"><xsl:value-of select="$path/v3:code/@displayName"/></xsl:param>
		<tr class="{$class}">
			<th class="formLabel">
				<xsl:value-of select="$label"/>
			</th>
			<td class="formItem">			
				<xsl:for-each select="$path/v3:value">
					<xsl:if test="position() > 1">,&#160;</xsl:if>
					<xsl:value-of select="./@displayName"/>
					<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>)</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="codelistedCharacteristicRow">
		<xsl:param name="path" select="."/>
		<xsl:param name="class">formTableRow</xsl:param>
		<xsl:param name="label"><xsl:value-of select="$path/v3:code/@displayName"/></xsl:param>
		<tr class="{$class}">
			<th class="formLabel">
				<xsl:value-of select="$label"/>
			</th>
			<td class="formItem">			
				<xsl:for-each select="$path/v3:value">
					<xsl:if test="position() > 1">,&#160;</xsl:if>
					<xsl:value-of select="./@code"/>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template name="spacedCharacteristicRow">
		<xsl:param name="path" select="."/>
		<xsl:param name="class">formTableRow</xsl:param>
		<xsl:param name="label"><xsl:value-of select="$path/v3:code/@displayName"/></xsl:param>
		<tr class="{$class}">
			<th class="formLabel">
				<xsl:value-of select="$label"/>
			</th>
			<td class="formItem">			
				<xsl:for-each select="$path/v3:value">
					<xsl:if test="position() > 1"><br/></xsl:if>
					<xsl:value-of select="./@displayName"/>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>	

	<xsl:template name="characteristics-old">
		<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
		<table class="formTablePetite fullWidth" cellSpacing="0" cellPadding="3">
			<tbody>
				<!-- [pmh WS_PM-028] use caption for first table row -->
				<caption class="formHeadingTitle">
					<xsl:value-of select="$labels/productCharacteristics[@lang = $lang]"/>
				</caption>
				<xsl:call-template name="codedCharacteristicRow"> <!-- Product Type is CV -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='1']"/>
					<xsl:with-param name="label" select="$labels/productType[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Colour is CV (original text), listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='2']"/>
					<xsl:with-param name="label" select="$labels/color[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Shape is CV (original text), listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='3']"/>
					<xsl:with-param name="label" select="$labels/shape[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="pqCharacteristicRow"> <!-- Size is PQ -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='4']"/>
					<xsl:with-param name="label" select="$labels/size[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="codedCharacteristicRow"> <!-- Score is CV -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='5']"/>
					<xsl:with-param name="label" select="$labels/score[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="stringCharacteristicRow"> <!-- Imprint Code is ST -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='6']"/>
					<xsl:with-param name="label" select="$labels/imprint[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Flavour is CV Listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='7']"/>
					<xsl:with-param name="label" select="$labels/flavor[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Pharmaceutical Standard is CV Listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='9']"/>
					<xsl:with-param name="label" select="$labels/pharmaStandard[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Schedule is CV Listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='10']"/>
					<xsl:with-param name="label" select="$labels/schedule[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="codelistedCharacteristicRow"> <!-- Therapeutic Class Listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='11']"/>
					<xsl:with-param name="label" select="$labels/therapeuticClass[@lang = $lang]"/>
				</xsl:call-template>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="packaging">
		<xsl:param name="path" select="."/>
		<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
		<table cellpadding="3" cellspacing="0" class="formTablePetite fullWidth">
			<!-- [pmh WS_PM-028] replace the top row of any product metadata tables with a caption -->
			<caption class="formHeadingTitle">
				<xsl:value-of select="$labels/packaging[@lang = $lang]"/>
			</caption>
			<tr>
				<th scope="col" width="1" class="formTitle">#</th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/itemCode[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/packageDescription[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/packageApprovalDate[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/packageRegStatus[@lang = $lang]"/></th>
			</tr>
			<xsl:for-each select="$path/v3:asContent/descendant-or-self::v3:asContent[not(*/v3:asContent)]">
				<xsl:call-template name="packageInfo">
					<xsl:with-param name="path" select="."/>
					<xsl:with-param name="number" select="position()"/>
				</xsl:call-template>
			</xsl:for-each>
		</table>
	</xsl:template>

	<!-- Override packageInfo template to consolidate rows that have the same package number - some templating still specific to FDA business rules -->
	<xsl:template name="packageInfo">
		<xsl:param name="path"/>
		<xsl:param name="number" select="1"/>
		<xsl:param name="containerPackagedPath" select="$path/ancestor-or-self::v3:asContent/*[self::v3:containerPackagedProduct or self::v3:containerPackagedMedicine]"/>
		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$number mod 2 = 0">formTableRow</xsl:when>
					<xsl:otherwise>formTableRowAlt</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<th scope="row" class="formItem">
				<xsl:value-of select="$number"/>
			</th>
			<td class="formItem">						
				<xsl:for-each select="$containerPackagedPath">
					<xsl:sort select="position()" order="descending"/>
					<xsl:variable name="current" select="."/>
					<xsl:for-each select="v3:code[1]/@code">
						<xsl:value-of select="."/>
					</xsl:for-each>
					<br/>
				</xsl:for-each>
			</td>
			<td class="formItem">
				<xsl:for-each select="$containerPackagedPath">
					<xsl:sort select="position()" order="descending"/>
					<xsl:variable name="current" select="."/>
					<xsl:for-each select="../v3:quantity">
						<xsl:for-each select="v3:numerator">
							<xsl:value-of select="@value"/>
							<xsl:text> </xsl:text>
							<xsl:if test="@unit[. != '1']">
								<xsl:value-of select="@unit"/>
							</xsl:if>
						</xsl:for-each>
						<xsl:value-of select="$labels/inConnective[@lang = $lang]"/>
						<xsl:for-each select="v3:denominator">
							<xsl:value-of select="@value"/>
							<xsl:text> </xsl:text>
						</xsl:for-each>
					</xsl:for-each>
					<xsl:value-of select="v3:formCode/@displayName"/>
					<br/>
				</xsl:for-each>
			</td>
			<td class="formItem">
				<xsl:for-each select="$containerPackagedPath">
					<xsl:sort select="position()" order="descending"/>
					<xsl:call-template name="string-to-date">
						<xsl:with-param name="text">
							<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:low/@value"/>
						</xsl:with-param>
					</xsl:call-template>
					<br/>
				</xsl:for-each>
			</td>
			<td class="formItem">	
				<xsl:for-each select="$containerPackagedPath">
					<xsl:sort select="position()" order="descending"/>
					<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:code/@displayName"/>
					<br/>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>
	
	<!-- Override FDA Part templating -->
	<xsl:template mode="subjects" match="v3:part/v3:partProduct|v3:part/v3:partMedicine">
		<!-- Only display the outer part packaging once -->
		<xsl:if test="not(../preceding-sibling::v3:part)">
			<xsl:if test="../../v3:asContent">
				<tr>
					<td>
						<xsl:call-template name="packaging">
							<xsl:with-param name="path" select="../.."/>
						</xsl:call-template>
					</td>
				</tr>
			</xsl:if>
			<xsl:for-each select="../..">
				<xsl:call-template name="MarketingInfo"/>
			</xsl:for-each>
			<tr>
				<td>
					<xsl:call-template name="partQuantity">
						<xsl:with-param name="path" select="../.."/>
					</xsl:call-template>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td>
				<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
				<table class="fullWidth" cellspacing="0" cellpadding="5">
					<!-- [pmh WS_PM-028] use caption instead of the first header row -->
					<caption class="contentTableTitle">
						<xsl:value-of select="$labels/part[@lang = $lang]"/> <xsl:value-of select="count(../preceding-sibling::v3:part)+1"/><xsl:value-of select="$labels/ofConnective[@lang = $lang]"/><xsl:value-of select="count(../../v3:part)"/>
					</caption>
					<xsl:call-template name="piMedNames"/>
				</table>
			</td>
		</tr>
		<xsl:call-template name="ProductInfoBasic"/>
		<xsl:call-template name="ProductInfoIng"/>
		<xsl:call-template name="MarketingInfo"/>
	</xsl:template>

	<xsl:template name="partQuantity">
		<xsl:param name="path" select="."/>
		<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
		<table cellpadding="3" cellspacing="0" class="formTablePetite fullWidth">
			<!-- [pmh WS_PM-028] replace the top row of any product metadata tables with a caption -->
			<caption class="formHeadingTitle"><xsl:value-of select="$labels/partQuantity[@lang = $lang]"/></caption>
			<tr>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/partNumber[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/pkgQuantity[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/ttlProdQty[@lang = $lang]"/></th>
			</tr>
			<xsl:for-each select="$path/v3:part">
				<tr>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
							<xsl:otherwise>formTableRowAlt</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<td class="formItem">
						<strong><xsl:value-of select="$labels/part[@lang = $lang]"/> <xsl:value-of select="position()"/></strong>
					</td>
					<td class="formItem">
						<xsl:for-each select="v3:quantity/v3:denominator">
							<xsl:value-of select="@value"/>
							<xsl:text> </xsl:text>
						</xsl:for-each>
						<xsl:value-of select="*[self::v3:partProduct or self::partMedicine]/v3:asContent/*[self::v3:containerPackagedProduct or self::v3:containerPackagedMedicine]/v3:formCode/@displayName"/>
						<xsl:text> </xsl:text>
					</td>							
					<td class="formItem">
						<xsl:value-of select="v3:quantity/v3:numerator/@value"/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:numerator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:numerator/@unit"/></xsl:if>
						<xsl:if test="(v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@value)!='1') 
														or (v3:quantity/v3:denominator/@unit and normalize-space(v3:quantity/v3:denominator/@unit)!='1')"> <xsl:value-of select="$labels/inConnective[@lang = $lang]"/><xsl:value-of select="v3:quantity/v3:denominator/@value"
														/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/>
							</xsl:if></xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="MarketingInfo">
		<xsl:if test="../v3:subjectOf/v3:approval|../v3:subjectOf/v3:marketingAct">
			<tr>
				<td> 
					<!-- [pmh] removed obsolete width="100%", replaced with fullWidth class -->
					<table cellpadding="3" cellspacing="0" class="formTablePetite fullWidth">
						<!-- [pmh WS_PM-028] replace the top row of any product metadata tables with a caption -->
						<caption class="formHeadingTitle">
							<xsl:value-of select="$labels/marketingInfo[@lang = $lang]"/>
						</caption>
						<tr>
							<th scope="col" class="formTitle"><xsl:value-of select="$labels/marketingCategory[@lang = $lang]"/></th>
							<th scope="col" class="formTitle"><xsl:value-of select="$labels/applicationNumber[@lang = $lang]"/></th>
							<th scope="col" class="formTitle"><xsl:value-of select="$labels/productApprovalDate[@lang = $lang]"/></th>
							<th scope="col" class="formTitle"><xsl:value-of select="$labels/cancellationDate[@lang = $lang]"/></th>
						</tr>
						<tr class="formTableRowAlt">
							<td class="formItem">
								<xsl:value-of select="../v3:subjectOf/v3:approval/v3:code/@displayName"/>
							</td>
							<td class="formItem">
								<xsl:value-of select="../v3:subjectOf/v3:approval/v3:id/@extension"/>
							</td>
							<td class="formItem">						
								<xsl:call-template name="string-to-date">
									<xsl:with-param name="text">
										<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:low/@value"/>
									</xsl:with-param>
								</xsl:call-template>
							</td>
							<td class="formItem">					
								<xsl:call-template name="string-to-date">
									<xsl:with-param name="text">
										<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:high/@value"/>
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
					</table>
				</td>
			</tr> 
		</xsl:if>
	</xsl:template>	

	<!-- SECTION MODEL AND NUMBER MODE -->
	<!-- Special mode to construct a section number. Apply to a sequence of sections on the ancestor-or-self axis. -->
	<!-- Shallow null-transform for anything but sections. -->
	<xsl:template mode="sectionNumber" match="/|@*|node()"/>
	<xsl:template mode="sectionNumber" match="v3:section">
		<xsl:value-of select="concat('.',count(parent::v3:component/preceding-sibling::v3:component[v3:section])+1)"/>
	</xsl:template>
	
	<xsl:template match="v3:section">
		<xsl:param name="sectionLevel" select="count(ancestor-or-self::v3:section)"/>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<div class="Section">
			<xsl:for-each select="v3:code">
				<xsl:attribute name="data-sectionCode"><xsl:value-of select="@code"/></xsl:attribute>
			</xsl:for-each>

			<!-- [pmh] switch @ID for v3:id/@root which is guaranteed to be a GUID to simplify section model in future -->
			<xsl:for-each select="v3:id/@root">
				<xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
			</xsl:for-each>
			
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Section'"/>
			</xsl:call-template>
			
			<!-- [pmh] @ID is still used for internal links, so it needs to be supported -->
			<xsl:for-each select="@ID">
				<a name="{.}"><xsl:text> </xsl:text></a>
			</xsl:for-each>
			<a name="section-{substring($sectionNumberSequence,2)}"><xsl:text> </xsl:text></a>
			
			<xsl:apply-templates select="v3:title">
				<xsl:with-param name="sectionLevel" select="$sectionLevel"/>
				<xsl:with-param name="sectionNumber" select="substring($sectionNumberSequence,2)"/>
			</xsl:apply-templates>
			<xsl:if test="boolean($show-data)">
				<xsl:apply-templates mode="data" select="."/>
			</xsl:if>
			<xsl:apply-templates select="@*|node()[not(self::v3:title)]"/>
			<xsl:call-template name="flushSectionTitleFootnotes"/>
		</div>
	</xsl:template>
	
	<!-- this template adds a vertical bar for xmChange, and is simplified from the FDA template substantially -->
	<xsl:template name="additionalStyleAttr">
		<xsl:if test="self::*[self::v3:paragraph]//v3:content[@styleCode[contains(.,'xmChange')]] or v3:content[@styleCode[contains(.,'xmChange')]] and not(ancestor::v3:table)">
			<xsl:attribute name="style">margin-left:-0.5em; padding-left:0.5em; border-left:1px solid;</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<!-- this template was used on the Title Page to show Control Number on a single line - currently unused -->
	<xsl:template mode="inline-title" match="v3:section">
		<div class="Section">
			<h2 style="display: inline;">
				<xsl:value-of select="v3:title"/>
				<xsl:text> </xsl:text>
			</h2>
			<xsl:value-of select="v3:text/v3:paragraph"/>
		</div>
	</xsl:template>

	<!-- this template is used on the Title Page to parse Authorization and Revision Dates -->
	<xsl:template mode="international-date-format" match="v3:section">
		<div class="Section">
			<h2>
				<xsl:value-of select="v3:title"/>
			</h2>
			<p>
				<xsl:call-template name="string-to-internationalized-date">
					<xsl:with-param name="text">
						<xsl:value-of select="v3:text/v3:paragraph"/>
					</xsl:with-param>
				</xsl:call-template>
			</p>
		</div>
	</xsl:template>

	<!-- This is the main page content, which renders for both screen, with Product Details in front, and print, with Product Details at end -->	
	<xsl:template mode="main-document" match="v3:structuredBody">
		<main class="col">
			<div class="container-fluid" id="main">
				<div class="row position-relative" id="wb-cont">
					<div class="col">
						<xsl:for-each select="v3:component/v3:section[not(v3:code/@code='0MP')]">
							<xsl:variable name="unique-section-id"><xsl:value-of select="v3:id/@root"/></xsl:variable>
							<xsl:choose>
								<xsl:when test="v3:code[@code='0TP']">
									<!-- TITLE PAGE - Note: force-page-break-after here does not work on FireFox -->
									<div class="card mb-2 force-page-break-after" id="{$unique-section-id}">
										<header class="card-header bg-aurora-accent1 text-white font-weight-bold hide-in-print">
											<xsl:value-of select="v3:title"/>
										</header>
										
										<!-- Extra hidden Title Page heading for semantic accessibility purposes -->
										<h1 class="hide-in-screen hide-offscreen"><xsl:value-of select="v3:title"/></h1>
										<div class="spl title-page title-page-row">
											<xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.1']/v3:text"/>
										</div>
										<div class="spl title-page-row title-page-rule-top">
											<div class="title-page-left">
												<xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.2']/v3:text"/>
												<!-- [#109] we can support multiple company address blocks by providing more min height in css -->								
											</div>
											<div class="title-page-right">
												<xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.3']" mode="international-date-format"/>
												<xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.4']" mode="international-date-format"/>
												<xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.5']"/>
											</div>
										</div>											
										<div class="spl title-page title-page-row">
											<xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.6']/v3:text"/>
										</div>
									</div>
								</xsl:when>
								<xsl:when test="v3:code[@code='0NOC']">
									<!-- Optional NOTICE OF COMPLIANCE WITH CONDITIONS section does not require page break -->
									<xsl:apply-templates mode="main-document" select="."/>									
								</xsl:when>
								<xsl:when test="v3:code[@code='1RMLC']">
									<!-- RECENT MAJOR LABEL CHANGES - These require extra styling to suppress table rules -->
									<div class="card mb-2" id="{$unique-section-id}">
										<header class="card-header bg-aurora-accent1 text-white font-weight-bold">
											<xsl:value-of select="v3:title"/>
										</header>
										<div class="spl recent-changes">
											<xsl:apply-templates select="."/>
										</div>
									</div>
								</xsl:when>
									<!-- Withhold the optional Biosimilar Biologic Drug and prepend to Part I after TOC -->
								<xsl:when test="v3:code[@code='0BBD']"></xsl:when>									
								<xsl:when test="v3:code[@code='pi00']">
									<!-- TABLE OF CONTENTS IMMEDIATELY PRECEDES PART I IN PRINT VERSION - WITHHOLD ACTUAL TOC FOR NOW -->
									<xsl:choose>
										<xsl:when test="$show-print-toc">
											<xsl:call-template name="render-toc"/>
										</xsl:when>
										<xsl:otherwise>
											<div class="hide-in-screen force-page-break-after">This is wher the TOC would be</div>
										</xsl:otherwise>
									</xsl:choose>
									<!-- Optional BIOSIMILAR BIOLOGIC DRUG, prepended to Part I if present -->
									<xsl:apply-templates mode="main-document" select="../../v3:component/v3:section[v3:code/@code='0BBD']"/>
									<!-- PART I HEALTH PROFESSIONAL INFORMATION requires page break after -->								
									<xsl:apply-templates mode="main-document" select=".">
										<xsl:with-param name="additional-classes">force-page-break-after</xsl:with-param>
									</xsl:apply-templates>									
								</xsl:when>
								<xsl:otherwise>
									<!-- ADDITIONAL SECTIONS - PART II and optional sections like PMI, etc -->
									<xsl:apply-templates mode="main-document" select=".">
											<xsl:with-param name="additional-classes">force-page-break-after</xsl:with-param>									
									</xsl:apply-templates>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<!-- SCREEN VERSION OF MANUFACTURED PRODUCT DETAIL -->
						<xsl:for-each select="v3:component/v3:section[v3:code/@code='0MP']">
							<xsl:variable name="unique-section-id"><xsl:value-of select="v3:id/@root"/></xsl:variable>
							<div class="card mb-2 hide-in-print" id="{$unique-section-id}">
								<header class="card-header bg-aurora-accent1 text-white font-weight-bold">
									<xsl:value-of select="$labels/productDetails[@lang = $lang]"/>
								</header>
								<!-- Company Details and Product Details Accordion Cards -->
								<div id="product-accordion">
									<xsl:apply-templates mode="screen" select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization"/>
									<xsl:apply-templates mode="screen" select="v3:subject/v3:manufacturedProduct"/>
								</div>
							</div>
						</xsl:for-each>
						<!-- SCREEN VERSION OF EXTRA SECTION FOR REVIEW ONLY -->
						<xsl:if test="$show-review-section">
							<div class="card mb-2 hide-in-print" id="review-section">
								<header class="card-header bg-success text-white font-weight-bold">REVIEW IMAGE ALT TEXT</header>
								<div class="px-2 pt-2">This section is used to review the Alt Text associated with image(s) within a Product Monograph.</div>
								<div id="review">
									<xsl:if test="not(//v3:observationMedia)">This Product Monograph does not contain images</xsl:if>
									<xsl:apply-templates select="//v3:observationMedia" mode="review"/>
								</div>
							</div>													
						</xsl:if>
						<!-- PRINT VERSION OF MANUFACTURED PRODUCT DETAIL will already have a page break after previous section -->
						<div class="hide-in-screen card spl" id="print-product-details">
							<h1>
								<xsl:call-template name="string-uppercase">
									<xsl:with-param name="text">
										<xsl:value-of select="$labels/productDetails[@lang = $lang]"/>
									</xsl:with-param>
								</xsl:call-template>
							</h1>
							<div class="spl">
								<xsl:apply-templates mode="print" select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization"/>
								<xsl:apply-templates mode="print" select="//v3:subject/v3:manufacturedProduct"/>
							</div>
						</div>
					</div>
				</div>				
			</div>
		</main>	
	</xsl:template>

	<xsl:template match="v3:section" mode="main-document">
		<xsl:param name="additional-classes"/>
		<xsl:variable name="unique-section-id"><xsl:value-of select="v3:id/@root"/></xsl:variable>
		<div class="card mb-2 pb-2 {$additional-classes}" id="{$unique-section-id}">
			<header class="card-header bg-aurora-accent1 text-white font-weight-bold">
				<xsl:value-of select="v3:title"/>
			</header>
			<div class="spl">
				<xsl:apply-templates select="."/>
			</div>
		</div>
	</xsl:template>

	<!-- Extra Templates for Print Table of Contents -->
	<xsl:template name="render-toc">
		<div class="hide-in-screen force-page-break-after card spl" id="print-toc">
			<h1><xsl:value-of select="$labels/tableOfContents[@lang = $lang]"/></h1><br/>
			<div class="spl"><xsl:value-of select="$labels/tocBoilerplate[@lang = $lang]"/></div>
			<ul class="toc">
				<xsl:apply-templates mode="toc" select="//v3:structuredBody/v3:component/v3:section[not(v3:code/@code='0MP')]"/>
				<li class="toc"><a href="#print-product-details"><xsl:value-of select="$labels/productDetails[@lang = $lang]"/></a></li>
				<li class="toc"><a href="#print-product-details"><xsl:value-of select="$labels/companyDetails[@lang = $lang]"/></a></li>
				<xsl:for-each select="//v3:subject/v3:manufacturedProduct">
					<xsl:variable name="unique-product-id">product-<xsl:value-of select="position()"/></xsl:variable>
					<li class="toc">
						<a href="#{$unique-product-id}">
							<xsl:apply-templates select="v3:manufacturedProduct" mode="generateUniqueLabel">
								<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
							</xsl:apply-templates>
						</a>
					</li>
				</xsl:for-each>
			</ul>
		</div>																							
	</xsl:template>
	
	<xsl:template mode="toc" match="v3:component/v3:section">
		<li class="toc"> 
			<a href="#{v3:id/@root}">
				<xsl:value-of select="v3:title"/>
			</a> 
		</li>
		<xsl:if test="self::node()[not(v3:code/@code='0TP')]/v3:component/v3:section and not($show-print-toc = 1)">
			<ul class="toc">
				<xsl:apply-templates mode="toc" select="v3:component/v3:section"/>
			</ul>
		</xsl:if>
	</xsl:template>												
	
	<!-- Print Version of each Manufactured Product - simplified version for Print Media -->
	<xsl:template match="v3:subject/v3:manufacturedProduct" mode="print">
		<xsl:variable name="unique-product-id">product-<xsl:value-of select="position()"/>
		</xsl:variable>
		<section>
			<div class="Section" id="{$unique-product-id}">
				<p/>
				<h2>
					<xsl:call-template name="string-uppercase">
						<xsl:with-param name="text">
							<xsl:copy>
								<xsl:apply-templates select="v3:manufacturedProduct" mode="generateUniqueLabel">
									<xsl:with-param name="position">
										<xsl:value-of select="position()"/>
									</xsl:with-param>
								</xsl:apply-templates>
							</xsl:copy>
						</xsl:with-param>
					</xsl:call-template>
				</h2>
				<xsl:apply-templates mode="subjects" select="."/>			
			</div>
		</section>
	</xsl:template>

	<!-- Print Version of Company Detail information - very simplified version for print -->
	<xsl:template match="v3:author/v3:assignedEntity/v3:representedOrganization" mode="print">
		<xsl:apply-templates mode="subjects" select="."/>
		<xsl:apply-templates mode="subjects" select="v3:assignedEntity/v3:assignedOrganization"/>	
	</xsl:template>

	<!-- NULL ROOT TEMPLATE - MIXIN SUPPORT DISABLED -->
	<xsl:template match="/" priority="1">
		<xsl:apply-templates select="/v3:document"/>
	</xsl:template>
	
	<!-- IMAGE SUPPORT - moved here from spl_common, and there are other renderMultiMedia templates there that are unused -->
	<!-- this one applies specifically to images embedded in paragraphs or tables, and was moved here to support prepending absolute paths -->
	<xsl:template mode="mixed" priority="1" match="v3:renderMultiMedia[@referencedObject and (ancestor::v3:paragraph or ancestor::v3:td or ancestor::v3:th)]">
		<xsl:variable name="reference" select="@referencedObject"/>
		<!-- see note anchoring and PCR 793 -->

		<xsl:if test="@ID">
			<a name="{@ID}"><xsl:text> </xsl:text></a>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="boolean(//v3:observationMedia[@ID=$reference]//v3:text)">
				<img alt="{//v3:observationMedia[@ID=$reference]//v3:text}" 
					src="{$base-uri}{//v3:observationMedia[@ID=$reference]//v3:reference/@value}">
					<xsl:apply-templates select="@*"/>
				</img>
			</xsl:when>
			<xsl:when test="not(boolean(//v3:observationMedia[@ID=$reference]//v3:text))">
				<img alt="Image from Drug Label Content" 
					src="{$base-uri}{//v3:observationMedia[@ID=$reference]//v3:reference/@value}">
					<xsl:apply-templates select="@*"/>
				</img>
			</xsl:when>
		</xsl:choose>
		<xsl:apply-templates mode="notCentered" select="v3:caption"/>
	</xsl:template>

	<!-- PARAGRAPH MODEL -->
	<xsl:template match="v3:paragraph">
		<p>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode">
					<!-- [pmh] this interdered with Boxed Statement StyleCodes and serves no purpose
					<xsl:if test="count(preceding-sibling::v3:paragraph)=0">
						<xsl:text>First</xsl:text>
					</xsl:if> -->
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

	<!-- TABLE MODEL-->
	<xsl:template match="v3:table">
		<xsl:if test="@ID">
			<a name="{@ID}"><xsl:text> </xsl:text></a>
		</xsl:if>
		<table>
			<!-- Default to 100% table width if none is specified -->
			<xsl:if test="not(@width) or @width='100%'">
				<xsl:attribute name="class">fullWidth</xsl:attribute>
			</xsl:if>
			<!-- Show table width if specified but not 100% -->
			<xsl:if test="@width and not(@width='100%')">
				<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
			</xsl:if>
			<!-- Default to thin border if frame is specified as 'border', suitable for Aurora-style tables -->
			<xsl:if test="@frame='border'">
				<xsl:attribute name="style">border: solid thin; border-color: #CCCCCC;</xsl:attribute>
			</xsl:if>
			<!-- Default to thick border if frame is specified as 'box', suitable for Boxed Warning -->
			<xsl:if test="@frame='box'">
				<xsl:attribute name="style">border: 2px solid black;</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*[name(.)!='width']|node()"/>
		</table>
	</xsl:template>
	<xsl:template match="v3:tr">
		<tr>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode">
					<xsl:choose>
						<xsl:when test="contains(ancestor::v3:table/@styleCode, 'Noautorules') or contains(ancestor::v3:section/v3:code/@code, '43683-2') and not(@styleCode)">
							<xsl:text></xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="position()=1">
								<xsl:text>First </xsl:text>
							</xsl:if>
							<xsl:if test="position()=last()">
								<xsl:text>Last </xsl:text>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates select="node()"/>
		</tr>
	</xsl:template>
	<xsl:template match="v3:th">
		<!-- determine our position to find out the associated col -->
		<xsl:param name="position" select="1+count(preceding-sibling::v3:td[not(@colspan[number(.) > 0])]|preceding-sibling::v3:th[not(@colspan[number(.) > 0])])+sum(preceding-sibling::v3:td/@colspan[number(.) > 0]|preceding-sibling::v3:th/@colspan[number(.) > 0])"/>
		<xsl:param name="associatedCol" select="(ancestor::v3:table/v3:colgroup/v3:col|ancestor::v3:table/v3:col)[$position]"/>
		<xsl:param name="associatedColgroup" select="$associatedCol/parent::v3:colgroup"/>
		<th>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode">
					<!-- Added default support for table rules=all, which supports an Aurora-style table -->
					<xsl:choose>
						<xsl:when test="ancestor::v3:table/@rules='all'">
							<xsl:text> Toprule Botrule Lrule Rrule </xsl:text>
						</xsl:when>						
						<xsl:otherwise>
							<xsl:if test="not(ancestor::v3:tfoot) and ((contains($associatedColgroup/@styleCode,'Lrule') and not($associatedCol/preceding-sibling::v3:col)) or contains($associatedCol/@styleCode, 'Lrule'))">
								<xsl:text> Lrule </xsl:text>
							</xsl:if>
							<xsl:if test="not(ancestor::v3:tfoot) and ((contains($associatedColgroup/@styleCode,'Rrule') and not($associatedCol/following-sibling::v3:col)) or contains($associatedCol/@styleCode, 'Rrule'))">
								<xsl:text> Rrule </xsl:text>
							</xsl:if>						
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:copy-of select="$associatedCol/@align"/>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</th>
	</xsl:template>
	<xsl:template match="v3:th/@align|v3:th/@char|v3:th/@charoff|v3:th/@valign|v3:th/@abbr|v3:th/@axis|v3:th/@headers|v3:th/@scope|v3:th/@rowspan|v3:th/@colspan">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:td">
		<!-- determine our position to find out the associated col -->
		<xsl:param name="position" select="1+count(preceding-sibling::v3:td[not(@colspan[number(.) > 0])]|preceding-sibling::v3:th[not(@colspan[number(.) > 0])])+sum(preceding-sibling::v3:td/@colspan[number(.) > 0]|preceding-sibling::v3:th/@colspan[number(.) > 0])"/>
		<xsl:param name="associatedCol" select="(ancestor::v3:table/v3:colgroup/v3:col|ancestor::v3:table/v3:col)[$position]"/>
		<xsl:param name="associatedColgroup" select="$associatedCol/parent::v3:colgroup"/>
		<td>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode">
					<!-- Added default support for table rules=all, which supports an Aurora-style table -->
					<xsl:choose>
						<xsl:when test="ancestor::v3:table/@rules='all'">
							<xsl:text> Toprule Botrule Lrule Rrule </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="not(ancestor::v3:tfoot) and ((contains($associatedColgroup/@styleCode,'Lrule') and not($associatedCol/preceding-sibling::v3:col)) or contains($associatedCol/@styleCode, 'Lrule'))">
								<xsl:text> Lrule </xsl:text>
							</xsl:if>
							<xsl:if test="not(ancestor::v3:tfoot) and ((contains($associatedColgroup/@styleCode,'Rrule') and not($associatedCol/following-sibling::v3:col)) or contains($associatedCol/@styleCode, 'Rrule'))">
								<xsl:text> Rrule </xsl:text>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:copy-of select="$associatedCol/@align"/>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</td>
	</xsl:template>

	<!-- TABLE FOOTNOTES - MODIFIED FOR ACCESSIBILITY -->
	<xsl:template match="v3:tfoot" name="flushtablefootnotes">
		<xsl:variable name="allspan">
			<xsl:choose>
				<xsl:when test="ancestor::v3:table[1]/v3:colgroup/@span">
					<xsl:value-of select="ancestor::v3:table[1]/v3:colgroup/@span"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(ancestor::v3:table[1]/v3:colgroup/v3:col|ancestor::v3:table[1]/v3:col)"/>
				</xsl:otherwise>
			</xsl:choose>			
		</xsl:variable>
		<xsl:if test="self::v3:tfoot or ancestor::v3:table[1]//v3:footnote">
			<tfoot>
				<xsl:if test="self::v3:tfoot">
					<xsl:apply-templates select="@*|node()"/>
				</xsl:if>
				<xsl:if test="ancestor::v3:table[1]//v3:footnote">
					<tr>
						<td colspan="{$allspan}" align="left">
<!--							<aside class="wb-fnote" role="note"> -->
								<dl class="Footnote">
									<xsl:apply-templates mode="footnote" select="ancestor::v3:table[1]/node()"/>				
								</dl>								
<!--							</aside> -->
						</td>
					</tr>
				</xsl:if>
			</tfoot>
		</xsl:if>
	</xsl:template>

	<!-- Override the original in spl_common.spl to always show numbers, rather than footnote marks
		 This is a change from the FDA templating, which always used footnote marks.
		 was: <xsl:value-of select="substring($footnoteMarks,$number,1)"/> -->
	<xsl:template name="footnoteMark">
		<xsl:param name="target" select="."/>
		<xsl:for-each select="$target[1]">
			<xsl:choose>
				<xsl:when test="ancestor::v3:title[parent::v3:document]">
					<!-- innermost table - FIXME: does not work for the constructed tables -->
					<xsl:variable name="number" select="count(preceding::v3:footnote)+1"/>
					<xsl:value-of select="$number"/>
				</xsl:when>
				<xsl:when test="ancestor::v3:table">
					<!-- innermost table - FIXME: does not work for the constructed tables -->
					<xsl:variable name="number">
						<xsl:number level="any" from="v3:table" count="v3:footnote"/>
					</xsl:variable>
					<xsl:value-of select="$number"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(preceding::v3:footnote[not(ancestor::v3:table or ancestor::v3:title[parent::v3:document])])+1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	<!-- MAIN HTML PAGE TEMPLATING -->
	<xsl:template match="/v3:document" priority="1">
		<html>
			<xsl:apply-templates select="." mode="html-head"/>
			<body data-spy="scroll" data-target="#navigation-sidebar" data-offset="1">
				<!-- [pmh] WS_PM-032/033 - I think we should target using the wet-boew skip to main, but we need to resolve some style issues first, translation is good -->
				<xsl:choose>
					<xsl:when test="$use-wet-boew-headers">
						<div class="global-header"><nav><ul id="wb-tphp">
							<li class="wb-slc"><a class="wb-sl" href="#wb-cont"><xsl:value-of select="$labels/skipToMainContent[@lang = $lang]"/></a></li>
						</ul></nav></div>
					</xsl:when>
					<xsl:otherwise>
						<a class="skip-main" href="#main"><xsl:value-of select="$labels/skipToMainContent[@lang = $lang]"/></a>				
					</xsl:otherwise>
				</xsl:choose>
					
				<header class="bg-aurora-accent1 hide-in-print mb-2" id="banner">
					<div class="text-white text-center p-2 font-weight-bold"><xsl:copy-of select="v3:title/node()"/></div>
				</header>
				<div class="container-fluid position-relative" id="content">
					<div class="row h-100">
						<xsl:apply-templates select="v3:component/v3:structuredBody" mode="sidebar-navigation"/>
						<xsl:apply-templates select="v3:component/v3:structuredBody" mode="main-document"/>
					</div>					
				</div>
				<!-- Withhold the jump to top button on the print version -->
				<xsl:if test="$show-jump-to-top">
					<div id="btnTopDiv" class="hide-in-print">
						<a id="btnTop" href="#"
							class="btn btn-warning btn-circle btn-md text-white" role="button">
							<i class="fa fa-arrow-up fa-3x"></i>
						</a>					
					</div>					
				</xsl:if>
				<xsl:call-template name="canada-screen-body-scripts"/>
			</body>
		</html>
	</xsl:template>
	
</xsl:transform>