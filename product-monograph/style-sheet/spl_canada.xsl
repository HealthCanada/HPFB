<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:v3="urn:hl7-org:v3" xmlns:str="http://exslt.org/strings" 
	xmlns:exsl="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" 
	exclude-result-prefixes="exsl msxsl v3 xsl xsi str">
	<xsl:import href="FDA spl_stylesheet_6_2/spl-common.xsl"/>
	<xsl:import href="spl_canada_screen.xsl"/>
	<xsl:import href="spl_canada_i18n.xsl"/>
	
	<!-- pmh retaining all of these unused parameters for future use -->
	<!-- Whether to show the clickable XML, set to "/.." instead of "1" to turn off -->
	<xsl:param name="show-subjects-xml" select="/.."/>
	<!-- Whether to show the data elements in special tables etc., set to "/.." instead of "1" to turn off -->
	<xsl:param name="show-data" select="/.."/>
	<!-- Whether to show section numbers, set to 1 to enable and "/.." to turn off-->
	<xsl:param name="show-section-numbers" select="/.."/>	
	<!-- This is the CSS link put into the output -->
	<xsl:param name="css">https://cease353.github.io/xtest/current/spl_canada.css</xsl:param>

	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="v3:document/v3:languageCode[@code='1']">en</xsl:when>
			<xsl:when test="v3:document/v3:languageCode[@code='2']">fr</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:output method="html" encoding="UTF-8" version="4.0" doctype-public="-//W3C//DTD HTML 4.01//EN" indent="no"/>
		
	<!-- OVERRIDE FDA STYLES FOR MANUFACTURED PRODUCT DETAILS -->	
	<!-- override FDA company info section, using Canadian French and English labels -->
	<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization">	
		<xsl:if test="(count(./v3:name)>0)">
			<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite">
				<tr>
					<td colspan="4" class="formHeadingReg">
						<span class="formHeadingTitle"><xsl:value-of select="$labels/labeler[@lang = $lang]"/> -&#160;</span>
						<xsl:value-of select="./v3:name"/> 
						<xsl:if test="./v3:id/@extension"> (<xsl:value-of select="./v3:id/@extension"/>)</xsl:if>
					</td>
				</tr>
				<xsl:call-template name="data-contactParty"/>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization">	
		<xsl:if test="./v3:name">
			<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite">
				<tr>
					<td colspan="4" class="formHeadingReg">
						<span class="formHeadingTitle"><xsl:value-of select="$labels/registrant[@lang = $lang]"/> -&#160;</span>
						<xsl:value-of select="./v3:name"/>
						<xsl:if test="./v3:id/@extension"> (<xsl:value-of select="./v3:id/@extension"/>)</xsl:if>
					</td>
				</tr>
				<xsl:call-template name="data-contactParty"/>
			</table>
		</xsl:if>
	</xsl:template>	

	<xsl:template name="data-contactParty">
		<xsl:for-each select="v3:contactParty">
			<xsl:if test="position() = 1">
				<tr>
					<th scope="col" class="formTitle"><xsl:value-of select="$labels/partyAddress[@lang = $lang]"/></th>
					<th scope="col" class="formTitle"><xsl:value-of select="$labels/partyAdditional[@lang = $lang]"/></th>
				</tr>
			</xsl:if>
			<tr class="formTableRowAlt">
				<td class="formItem">		
					<table>
						<tr><td><xsl:value-of select="v3:addr/v3:streetAddressLine"/></td></tr>
						<tr><td>
								<xsl:value-of select="v3:addr/v3:city"/>
								<xsl:if test="string-length(v3:addr/v3:state)>0">,&#160;<xsl:value-of select="v3:addr/v3:state"/></xsl:if>
								<xsl:if test="string-length(v3:addr/v3:postalCode)>0">,&#160;<xsl:value-of select="v3:addr/v3:postalCode"/></xsl:if>
							</td>
						</tr>
						<tr><td><xsl:value-of select="v3:addr/v3:country/@displayName"/></td></tr>
					</table>
				</td>
				<td class="formItem">
					<div><xsl:value-of select="$labels/partyTel[@lang = $lang]"/><xsl:text>: </xsl:text>
					<xsl:value-of select="substring-after(v3:telecom/@value[starts-with(.,'tel:')][1], 'tel:')"/></div>
					<xsl:for-each select="v3:telecom/@value[starts-with(.,'fax:')]">
						<div><xsl:text>Fax: </xsl:text>
						<xsl:value-of select="substring-after(., 'fax:')"/></div>
					</xsl:for-each>
					<xsl:for-each select="v3:telecom/@value[starts-with(.,'mailto:')]">
						<div><xsl:value-of select="$labels/partyEmail[@lang = $lang]"/><xsl:text>: </xsl:text>
						<xsl:value-of select="substring-after(., 'mailto:')"/></div>
					</xsl:for-each>
					<xsl:for-each select="v3:telecom/@value[starts-with(.,'http:') or starts-with(.,'https:')]">
						<div><xsl:value-of select="$labels/partyWeb[@lang = $lang]"/><xsl:text>: </xsl:text>
						<xsl:value-of select="."/></div>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>	
	
	<!-- override FDA Product Info section, using Canadian French and English labels - note, we could drop the Alt class for row banding -->
	<xsl:template name="ProductInfoBasic">
		<tr>
			<td>
				<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
					<tr>
						<td colspan="2" class="formHeadingTitle"><xsl:value-of select="$labels/productInfo[@lang = $lang]"/></td>
					</tr>
					<tr class="formTableRowAlt">
						<td class="formLabel"> <!-- Product Brand Name -->
							<xsl:value-of select="$labels/brandName[@lang = $lang]"/>
						</td>
						<td class="formItem"><xsl:value-of select="v3:name"/></td>
					</tr>
					<tr class="formTableRow">
						<td class="formLabel"> <!-- Product Generic Name -->
							<xsl:value-of select="$labels/nonPropName[@lang = $lang]"/>
						</td>
						<td class="formItem"><xsl:value-of select="v3:asEntityWithGeneric/v3:genericMedicine/v3:name"/></td>
					</tr>
					<tr class="formTableRowAlt">
						<td class="formLabel"> <!-- Product DIN -->
							<xsl:value-of select="$labels/din[@lang = $lang]"/>
						</td>
						<td class="formItem"><xsl:value-of select="v3:code/@code"/></td>
					</tr>
					<tr class="formTableRow">
						<td class="formLabel"> <!-- Product Substance Administration Route -->
							<xsl:value-of select="$labels/adminRoute[@lang = $lang]"/>
						</td>
						<td class="formItem"><xsl:value-of select="../v3:consumedIn/v3:substanceAdministration/v3:routeCode/@displayName"/></td>
					</tr>
					<tr class="formTableRowAlt">
						<td class="formLabel"> <!-- Product Dosage Form -->
							<xsl:value-of select="$labels/dosageForm[@lang = $lang]"/>
						</td>
						<td class="formItem"><xsl:value-of select="v3:formCode/@displayName"/></td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>
	
	<!-- Overide FDA Ingredients - this is a helper template to simplify header generation -->
	<xsl:template name="IngredientHeader">
		<xsl:param name="title-label">
			<xsl:value-of select="$labels/activeIngredients[@lang = $lang]"/>
		</xsl:param>
		<xsl:param name="column-count">3</xsl:param>
		<tr>
			<td colspan="{$column-count}" class="formHeadingTitle">	
				<xsl:value-of select="$title-label"/>
			</td>
		</tr>
		<tr>
			<th class="formTitle" scope="col">
				<xsl:value-of select="$labels/ingredientName[@lang = $lang]"/>
			</th>
			<xsl:if test="$column-count = '3'">
				<th class="formTitle" scope="col">
					<xsl:value-of select="$labels/basisOfStrength[@lang = $lang]"/>
				</th>
			</xsl:if>
			<th class="formTitle" scope="col">
				<xsl:value-of select="$labels/strength[@lang = $lang]"/>
			</th>
		</tr>		
	</xsl:template>	
	
	<!-- extra logic required for URG_PQ Active Ingredients -->
	<xsl:template match="v3:quantity/v3:numerator">
		<xsl:choose>
			<xsl:when test="v3:low and v3:high">
				<xsl:value-of select="v3:low/@value"/>					
				<xsl:value-of select="$labels/toConnective[@lang = $lang]"/>
				<xsl:value-of select="v3:high/@value"/>&#160;								
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@value"/>&#160;
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
	
	<!-- display the ingredient information (both active and inactive) -->
	<xsl:template name="ActiveIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<xsl:call-template name="IngredientHeader"/>
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
								<xsl:value-of select="v3:name"/>
							</strong>
							<xsl:text> (</xsl:text>
							<xsl:for-each select="v3:code/@code">
								<xsl:value-of select="."/>
								<xsl:if test="position()!=last()"><xsl:value-of select="$labels/andConnective[@lang = $lang]"/></xsl:if>
							</xsl:for-each>
							<xsl:text>) </xsl:text>
							<xsl:if test="normalize-space(v3:activeMoiety/v3:activeMoiety/v3:code/@displayName)">
								<xsl:text> (</xsl:text>
								<xsl:for-each select="v3:activeMoiety/v3:activeMoiety/v3:code">
									<xsl:value-of select="@displayName"/>
									<xsl:text> - </xsl:text>
									<xsl:value-of select="@code"/>
									<xsl:if test="position()!=last()">, </xsl:if>
								</xsl:for-each>
								<xsl:text>) </xsl:text>
							</xsl:if>
						</td>
						<td class="formItem">
							<xsl:choose>
								<xsl:when test="../@classCode='ACTIR'">
									<xsl:value-of select="v3:asEquivalentSubstance/v3:definingSubstance/v3:name"/>
								</xsl:when>
								<xsl:when test="../@classCode='ACTIB'">
									<xsl:value-of select="v3:name"/>
								</xsl:when>
								<xsl:when test="../@classCode='ACTIM'">
									<xsl:value-of select="v3:activeMoiety/v3:activeMoiety/v3:name"/>
								</xsl:when>
							</xsl:choose>
						</td>
					</xsl:for-each>
					<td class="formItem">
						<!-- hopefully this works for URG_PQ and beyond - removed a lot of extra normalize-space -->
						<xsl:apply-templates select="v3:quantity/v3:numerator"/>
						<xsl:if test="(v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@value)!='1') 
													or (v3:quantity/v3:denominator/@unit and normalize-space(v3:quantity/v3:denominator/@unit)!='1')"> <xsl:value-of select="$labels/inConnective[@lang = $lang]"/><xsl:value-of select="v3:quantity/v3:denominator/@value"/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/>
						</xsl:if></xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="InactiveIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<xsl:call-template name="IngredientHeader">
				<xsl:with-param name="title-label">
					<xsl:value-of select="$labels/inactiveIngredients[@lang = $lang]"/>					
				</xsl:with-param>
				<xsl:with-param name="column-count">2</xsl:with-param>
			</xsl:call-template>
			<xsl:for-each select="v3:ingredient[@classCode='IACT']|v3:inactiveIngredient">
				<tr>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
							<xsl:otherwise>formTableRowAlt</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:for-each select="(v3:ingredientSubstance|v3:inactiveIngredientSubstance)[1]">
						<td class="formItem">
							<!-- TODO is this correct for more than one code? is the cardinality guaranteed [1..1]? -->							
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
		</table>
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

	<xsl:template name="stringCharacteristicRow">
		<xsl:param name="path" select="."/>
		<xsl:param name="class">formTableRow</xsl:param>
		<xsl:param name="label"><xsl:value-of select="$path/v3:code/@displayName"/></xsl:param>
		<tr class="{$class}">
			<td class="formLabel">
				<xsl:value-of select="$label"/>
			</td>
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
			<td class="formLabel">
				<xsl:value-of select="$label"/>
			</td>
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
			<td class="formLabel">
				<xsl:value-of select="$label"/>
			</td>
			<td class="formItem">			
				<xsl:for-each select="$path/v3:value">
					<xsl:if test="position() > 1">,&#160;</xsl:if>
					<xsl:value-of select="./@displayName"/>
					<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>)</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>

<!-- pmh - CV template from FDA:
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'CV' or @xsi:type = 'CE' or @xsi:type = 'CE']">
		<td class="formItem">
			<xsl:value-of select=".//@displayName[1]"/>
		</td>
		<td class="formItem">
			<xsl:value-of select=".//@code[1]"/>
		</td>
	</xsl:template>
-->


	<xsl:template name="characteristics-old">
		<table class="formTablePetite" cellSpacing="0" cellPadding="3" width="100%">
			<tbody>
				<tr>
					<td class="formHeadingTitle" colspan="2">
						<xsl:value-of select="$labels/productCharacteristics[@lang = $lang]"/>
					</td>
				</tr>
				<xsl:call-template name="codedCharacteristicRow"> <!-- Product Type is CV -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='1']"/>
					<xsl:with-param name="label" select="$labels/productType[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Colour is CV (original text), listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='2']"/>
					<xsl:with-param name="label" select="$labels/color[@lang = $lang]"/>
					<xsl:with-param name="class">formTableRowAlt</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Shape is CV (original text), listed -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='3']"/>
					<xsl:with-param name="label" select="$labels/shape[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="pqCharacteristicRow"> <!-- Size is PQ -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='4']"/>
					<xsl:with-param name="label" select="$labels/size[@lang = $lang]"/>
					<xsl:with-param name="class">formTableRowAlt</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="codedCharacteristicRow"> <!-- Score is CV -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='5']"/>
					<xsl:with-param name="label" select="$labels/score[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="stringCharacteristicRow"> <!-- Imprint Code is ST -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='6']"/>
					<xsl:with-param name="label" select="$labels/imprint[@lang = $lang]"/>
					<xsl:with-param name="class">formTableRowAlt</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Flavour is CV -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='7']"/>
					<xsl:with-param name="label" select="$labels/flavor[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="codedCharacteristicRow"> <!-- Combination Product is CV -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='8']"/>
					<xsl:with-param name="label" select="$labels/combinationProduct[@lang = $lang]"/>
					<xsl:with-param name="class">formTableRowAlt</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="codedCharacteristicRow"> <!-- Pharmaceutical Standard is CV -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='9']"/>
					<xsl:with-param name="label" select="$labels/pharmaStandard[@lang = $lang]"/>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Schedule is CV, Listed? -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='10']"/>
					<xsl:with-param name="label" select="$labels/schedule[@lang = $lang]"/>
					<xsl:with-param name="class">formTableRowAlt</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="listedCharacteristicRow"> <!-- Therapeutic Class, Listed? -->
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='11']"/>
					<xsl:with-param name="label" select="$labels/therapeuticClass[@lang = $lang]"/>
				</xsl:call-template>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="packaging">
		<xsl:param name="path" select="."/>
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="5" class="formHeadingTitle"><xsl:value-of select="$labels/packaging[@lang = $lang]"/></td>
			</tr>
			<tr>
				<th scope="col" width="1" class="formTitle">#</th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/itemCode[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/packageDescription[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/approvalDate[@lang = $lang]"/></th>
				<th scope="col" class="formTitle"><xsl:value-of select="$labels/cancellationDate[@lang = $lang]"/></th>
			</tr>
			<xsl:for-each select="$path/v3:asContent/descendant-or-self::v3:asContent[not(*/v3:asContent)]">
				<xsl:call-template name="packageInfo">
					<xsl:with-param name="path" select="."/>
					<xsl:with-param name="number" select="position()"/>
				</xsl:call-template>
			</xsl:for-each>
		</table>
	</xsl:template>

	<!-- override packageInfo template to consolidate rows that have the same package number - some templating still specific to FDA business rules -->
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
						<!-- TODO: this could be a lot simpler now that it is not constrained by controlled vocabulary -->
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
					<!-- pmh remove old references to FDA characteristic controlled vocabulary:
					<xsl:for-each select="../v3:subjectOf/v3:characteristic">
						<xsl:if test="../../v3:quantity or ../../v3:containerPackagedProduct[v3:formCode[@displayName]] or ../preceding::v3:subjectOf"></xsl:if>
						<xsl:variable name="name" select="($def/v3:code/@displayName|$def/v3:code/@p:displayName)[1]" xmlns:p="http://pragmaticdata.com/xforms" />
						<xsl:variable name="def" select="$CHARACTERISTICS/*/*/v3:characteristic[v3:code[@code = current()/v3:code/@code and @codeSystem = current()/v3:code/@codeSystem]][1]"/>
						<xsl:variable name="cname" select="$CHARACTERISTICS/*/*/v3:characteristic[v3:code[@code = current()/v3:code/@code]]/v3:value[@code = current()/v3:value/@code]/@displayName"/>
						<xsl:choose>
							<xsl:when test="$cname">
								<xsl:text>; </xsl:text>
								<xsl:value-of select="$cname" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>; </xsl:text>
								<xsl:value-of select="$name"/>
								<xsl:text> = </xsl:text>
								<xsl:value-of select="(v3:value[not(../v3:code/@code = 'SPLCMBPRDTP')]/@code|v3:value/@value)[1]"/>
							</xsl:otherwise>
						</xsl:choose>						
					</xsl:for-each> -->
					<br/>
				</xsl:for-each>
			</td>
			<td class="formItem">	
				<xsl:for-each select="$containerPackagedPath">
					<xsl:call-template name="string-to-date">
						<xsl:with-param name="text">
							<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:low/@value"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</td>
			<td class="formItem">					
				<xsl:for-each select="$containerPackagedPath">
					<xsl:call-template name="string-to-date">
						<xsl:with-param name="text">
							<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:high/@value"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>
	
	<!-- override FDA Part templating -->
	<xsl:template mode="subjects" match="v3:part/v3:partProduct|v3:part/v3:partMedicine">
		<!-- only display the outer part packaging once -->
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
				<table width="100%" cellspacing="0" cellpadding="5">
					<tr>
						<td class="contentTableTitle"><xsl:value-of select="$labels/part[@lang = $lang]"/> <xsl:value-of select="count(../preceding-sibling::v3:part)+1"/><xsl:value-of select="$labels/ofConnective[@lang = $lang]"/><xsl:value-of select="count(../../v3:part)"/></td>
					</tr>
					<xsl:call-template name="piMedNames"/>
				</table>
			</td>
		</tr>
			<xsl:call-template name="ProductInfoBasic"/>
			<xsl:call-template name="ProductInfoIng"/>
		<tr>
			<td>
				<xsl:call-template name="image">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='SPLIMAGE']"/>
				</xsl:call-template>
			</td>
		</tr>
		<tr>
			<td class="normalizer">
				<xsl:call-template name="MarketingInfo"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="partQuantity">
		<xsl:param name="path" select="."/>
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="5" class="formHeadingTitle"><xsl:value-of select="$labels/partQuantity[@lang = $lang]"/></td>
			</tr>
			<tr>
				<th scope="col" width="5" class="formTitle"><xsl:value-of select="$labels/partNumber[@lang = $lang]"/></th>
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
					<td width="5" class="formItem">
						<strong><xsl:value-of select="$labels/part[@lang = $lang]"/> <xsl:value-of select="position()"/></strong>
					</td>
					<td class="formItem">
						<!-- TODO cleanup - are there ever going to be multiple quantities? what is the cardinality here? -->
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
			<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite">
				<tr>
					<td colspan="4" class="formHeadingReg"><span class="formHeadingTitle" ><xsl:value-of select="$labels/marketingInfo[@lang = $lang]"/></span></td>
				</tr>
				<tr>
					<th scope="col" class="formTitle"><xsl:value-of select="$labels/marketingCategory[@lang = $lang]"/></th>
					<th scope="col" class="formTitle"><xsl:value-of select="$labels/applicationNumber[@lang = $lang]"/></th>
					<th scope="col" class="formTitle"><xsl:value-of select="$labels/approvalDate[@lang = $lang]"/></th>
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
		</xsl:if>
	</xsl:template>	
			
	<!-- This is the main page content, which renders for both screen, with Product Details in front, and print, with Product Details at end -->	
	<xsl:template match="v3:structuredBody" mode="main-document">
		<main class="col">
			<div class="container-fluid" id="main">
				<div class="row position-relative">
					<div class="col">
						<xsl:for-each select="v3:component/v3:section">
							<xsl:variable name="unique-section-id"><xsl:value-of select="@ID"/></xsl:variable>
							<xsl:variable name="tri-code-value" select="substring(v3:code/@code, string-length(v3:code/@code)-2)"/>
							<xsl:choose>
								<xsl:when test="v3:code[@code='MP']">
									<!-- PRODUCT DETAIL -->
									<section class="card mb-2 hide-in-print" id="{$unique-section-id}">
										<h5 class="card-header text-white bg-aurora-accent1">
											<xsl:value-of select="$labels/productDetails[@lang = $lang]"/>
										</h5>
										<!-- Company Details and Product Details Accordion Cards -->
										<div id="product-accordion">
											<xsl:apply-templates select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization" mode="card"/>
											<xsl:apply-templates select="v3:subject/v3:manufacturedProduct" mode="card"/>
										</div>
									</section>
								</xsl:when>
								<xsl:when test="$tri-code-value = '001'">
									<!-- TITLE PAGE - Note: force-page-break here does not work on FireFox -->
									<section class="card mb-2 force-page-break" id="{$unique-section-id}">
										<h5 class="card-header text-white bg-aurora-accent1">
											<xsl:value-of select="v3:code/@displayName"/>
										</h5>
										<div class="spl title-page p-3">
											<xsl:for-each select="v3:component[1]/v3:section">
												<xsl:apply-templates select="v3:title"/>
												<xsl:apply-templates select="v3:text"/>
											</xsl:for-each>
										</div>
										<div class="spl container p-5">
											<div class="row">
												<div class="col-6">
													<xsl:for-each select="v3:component[2]/v3:section">
														<xsl:apply-templates select="v3:title"/>
														<xsl:apply-templates select="v3:text"/>
													</xsl:for-each>
												</div>
												<div class="col-6">
													<!-- TODO - this should probably just render every subsection with position greater than [2] -->
													<xsl:for-each select="v3:component[3]/v3:section">
														<xsl:apply-templates select="v3:title"/>
														<xsl:apply-templates select="v3:text"/>
													</xsl:for-each>
													<xsl:for-each select="v3:component[4]/v3:section">
														<xsl:apply-templates select="v3:title"/>
														<xsl:apply-templates select="v3:text"/>
													</xsl:for-each>
													<xsl:for-each select="v3:component[5]/v3:section">
														<xsl:apply-templates select="v3:title"/>
														<xsl:apply-templates select="v3:text"/>
													</xsl:for-each>
												</div>
											</div>
										</div>
									</section>
									<!-- PRINT ONLY TOC ON A SEPARATE PAGE -->
									<!-- pmh - I do not think this is going to work
									<section class="force-page-break hide-in-screen" id="print-table-of-contents">
										<div class="spl">
											TEST TEST TEST POC FOR TABLE OF CONTENTS from Hadlima deb4ec67-8764-4b72-b7a5-0bae88db11a3
											<ol>
												<li class="frontmatter"><a href="#a16a94eb-e2be-45c0-8b2e-15d0d0eebea8">Part one</a></li>
												<li class="frontmatter"><a href="#d6a947eb-e2be-45c0-8b2e-15d0d0eebed8">Part two</a></li>
												<li class="bodymatter"><a href="#baa4d498-0fc3-4e44-b4b6-550140d4de5d">Part threebody</a></li>
											</ol>
										</div>
									</section> -->
								</xsl:when>
								<xsl:when test="$tri-code-value = '007'">
									<!-- RECENT MAJOR LABEL CHANGES -->
									<section class="card mb-2" id="{$unique-section-id}">
										<h5 class="card-header text-white bg-aurora-accent1">
											<xsl:value-of select="v3:code/@displayName"/>
										</h5>
										<div class="spl recent-changes">
											<xsl:apply-templates select="."/>
										</div>
									</section>
								</xsl:when>
								<xsl:otherwise>
									<!-- NAVIGATION FOR DIFFERENT PARTS -->								
									<section class="card mb-2 pb-2" id="{$unique-section-id}">
										<h5 class="card-header text-white bg-aurora-accent1">
											<xsl:value-of select="v3:code/@displayName"/>
										</h5>
										<div class="spl">
											<xsl:apply-templates select="."/>
										</div>
									</section>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<!-- PRINT VERSION OF MANUFACTURED PRODUCT -->
						<section class="hide-in-screen card" id="print-product-details">
							<h5 class="card-header text-white">
								<xsl:value-of select="$labels/productDetails[@lang = $lang]"/>
							</h5>
							<div class="spl">
								<xsl:apply-templates mode="print" select="v3:author/v3:assignedEntity/v3:representedOrganization"/>
								<xsl:apply-templates mode="print" select="//v3:subject/v3:manufacturedProduct"/>
							</div>
						</section>
					</div>
				</div>				
			</div>
		</main>	
	</xsl:template>

	<!-- Print Version of each Manufactured Product - very simplified version for print -->
	<xsl:template match="v3:subject/v3:manufacturedProduct" mode="print">
		<section>
			<div class="Section">
				<p></p>
				<h2>
					<xsl:apply-templates select="v3:manufacturedProduct" mode="generateUniqueLabel">
						<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
					</xsl:apply-templates>
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

	<!-- MAIN HTML PAGE TEMPLATING -->
	<xsl:template match="/v3:document" priority="1">
		<html>
			<xsl:apply-templates select="." mode="html-head"/>
			<body data-spy="scroll" data-target="#navigation-sidebar" data-offset="1">
				<div class="bg-aurora-accent1 hide-in-print">
					<h2 class="text-white text-center p-2"><xsl:copy-of select="v3:title/node()"/></h2>
				</div>
					<div class="container-fluid position-relative" id="content">
					<div class="row h-100">
						<xsl:apply-templates select="v3:component/v3:structuredBody" mode="sidebar-navigation"/>
						<xsl:apply-templates select="v3:component/v3:structuredBody" mode="main-document"/>
					</div>
				</div>
<!--				<div class="global-footer">
					<footer id="wb-info">
						<div class="landscape">
							<nav class="container wb-navcurr">
								<h2 class="wb-inv">About government</h2>
								<ul class="list-unstyled colcount-sm-2 colcount-md-3">               
									<li><a href="/en/contact.html">Contact us</a></li>            
									<li><a href="/en/government/dept.html">Departments and agencies</a></li>     
									<li><a href="/en/government/publicservice.html">Public service and military</a></li>
									<li><a href="/en/news.html">News</a></li>  
									<li><a href="/en/government/system/laws.html">Treaties, laws and regulations</a></li>
									<li><a href="/en/transparency/reporting.html">Government-wide reporting</a></li>
									<li><a href="http://pm.gc.ca/en">Prime Minister</a></li>
									<li><a href="/en/government/system.html">About government</a></li>
									<li><a href="http://open.canada.ca/en">Open government</a></li>   
								</ul>
							</nav>
						</div>
						<div class="brand">
							<div class="container">
								<div class="row">
									<nav class="col-md-10 ftr-urlt-lnk">
										<h2 class="wb-inv">About this site</h2>
										<ul>                             
											<li><a href="/en/social.html">Social media</a></li>
											<li><a href="/en/mobile.html">Mobile applications</a></li>
											<li><a href="/en/government/about.html">About Canada.ca</a></li>
											<li><a href="/en/transparency/terms.html">Terms and conditions</a></li>
											<li><a href="/en/transparency/privacy.html">Privacy</a></li>
										</ul>
									</nav>
									<div class="col-xs-6 visible-sm visible-xs tofpg">
										<a href="#wb-cont">Top of page <span class="glyphicon glyphicon-chevron-up"></span></a>
									</div>
									<div class="col-xs-6 col-md-2 text-right">
										<img src="http://canada.ca/etc/designs/canada/wet-boew/assets/wmms-blk.svg" alt="Symbol of the Government of Canada"/>
									</div>
								</div>
							</div>
						</div>
					</footer>
				</div> -->
				<xsl:call-template name="canada-screen-body-footer"/>
			</body>
		</html>
	</xsl:template>
	
</xsl:transform>