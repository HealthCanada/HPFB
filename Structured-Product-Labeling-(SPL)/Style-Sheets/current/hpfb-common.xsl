<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<xsl:transform version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:v3="urn:hl7-org:v3" 
	xmlns:str="http://exslt.org/strings" 
	xmlns:exsl="http://exslt.org/common" 
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" 
	exclude-result-prefixes="exsl msxsl v3 xsl xsi str">
	<xsl:template match="/" priority="1">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template name="productNames">
		<xsl:for-each select="//v3:manufacturedProduct/v3:manufacturedProduct">
			<h2 id="product{count(preceding::v3:manufacturedProduct/v3:manufacturedProduct)}h" style="padding-left:3em;margin-top:1.5ex;"><a href="#product{count(preceding::v3:manufacturedProduct/v3:manufacturedProduct)}">
			<xsl:value-of select="./v3:name"/>
			<xsl:variable name="strength">
				<xsl:for-each select="./v3:ingredient[starts-with(@classCode,'ACTI')]/v3:quantity/v3:numerator">
					<xsl:apply-templates mode="productNames" select="."/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:if test="$strength !=''">
				<xsl:variable name="strLen" select="string-length($strength)"/>
				<xsl:value-of select="concat(' - ', substring($strength, 1, $strLen - 1))"/>
			</xsl:if>
			</a></h2>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="productNames" match="node()">
		<xsl:choose>
		<xsl:when test="./@value">
			<xsl:value-of select="./@value"/><xsl:value-of select="'/'"/>
		</xsl:when>
		<xsl:when test=".">
			<xsl:value-of select="'-'"/><xsl:value-of select="'/'"/>
		</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="formatAddress">
		<xsl:param name="addr" select="/.."/>
		<xsl:value-of select="$addr/v3:streetAddressLine"/><br/>
		<xsl:value-of select="$addr/v3:city"/>
		<xsl:if test="string-length($addr/v3:state)&gt;0">,&#xA0;<xsl:value-of select="$addr/v3:state"/></xsl:if><br/>
		<xsl:if test="string-length($addr/v3:postalCode)&gt;0"><xsl:value-of select="$addr/v3:postalCode"/></xsl:if><br/>
		<xsl:if test="$addr/v3:country"><xsl:call-template name="hpfb-label"><xsl:with-param name="codeSystem" select="$country-code-oid"/><xsl:with-param name="code" select="$addr/v3:country/@code"/></xsl:call-template></xsl:if>
	</xsl:template>
	<xsl:template mode="FORMAT" match="*/v3:addr">
		<div class="addressContainer">
			<div class="address">
				<span class="label" style="width:5em;">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10003'"/>
						<!-- Address -->
					</xsl:call-template>:
				</span>
				<span class="value">
					<xsl:value-of select="./v3:streetAddressLine"/>
				</span>
			</div>
			<xsl:if test="v3:city">
			<div class="address">
				<span class="label" style="width:5em;">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10011'"/>
						<!-- cityStateZip -->
					</xsl:call-template>:&#160;
				</span>
				<span class="value"><xsl:value-of select="./v3:city"/></span>
			</div>
			</xsl:if>
			<xsl:if test="v3:state">
			<div class="address">
				<span class="label" style="width:5em;">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10142'"/>
						<!-- Province -->
					</xsl:call-template>:&#160;</span>
				<span class="value"><xsl:value-of select="./v3:state"/></span>
			</div>
			</xsl:if>
			<xsl:if test="v3:postalCode">
			<div class="address">
				<span class="label" style="width:5em;">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10143'"/>
						<!-- Postal Code -->
					</xsl:call-template>:
				</span>
				<span class="value"><xsl:value-of select="v3:postalCode"/></span>
			</div>
			</xsl:if>
			<xsl:if test="v3:country">
			<div class="address">
				<span class="label" style="width:5em;">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10106'"/>
						<!-- Country -->
					</xsl:call-template>:
				</span>
				<span class="value">
					<xsl:call-template name="hpfb-label">
						<xsl:with-param name="codeSystem" select="$country-code-oid"/>
						<xsl:with-param name="code" select="./v3:country/@code"/>
					</xsl:call-template>
				</span>
			</div>
			</xsl:if>
		</div>
	</xsl:template>
	<xsl:template name="performances">
		<xsl:for-each select="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:performance">
		<table class="contentTablePetite" cellspacing="0" width="100%">
		<tbody>
			<tr>
				<td colspan="3" class="formHeadingReg">
					<xsl:value-of select="./v3:actDefinition/v3:product/v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:code/@displayName"/>
				</td>
			</tr>
			<tr>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10051'"/>
						<!-- name -->
					</xsl:call-template>
				</td>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10003'"/>
						<!-- address -->
					</xsl:call-template>
				</td>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10129'"/>
						<!-- API -->
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td class="formItem">
					<xsl:value-of select="../v3:assignedOrganization/v3:name"/>
				</td>
				<td class="formItem">
					<xsl:apply-templates mode="format" select="../v3:assignedOrganization/v3:addr"/>
				</td>
				<td>
					<xsl:value-of select="./v3:actDefinition/v3:code/@displayName"/>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="formHeadingReg">footer???
				</td>
			</tr>
		</tbody>
		</table>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="storageConditions">
		<table class="contentTablePetite" cellspacing="0" width="100%">
		<tbody>
			<tr>
				<td colspan="3" class="formHeadingReg">???
				</td>
			</tr>
			<tr>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10137'"/>
						<!-- Container Closure System -->
					</xsl:call-template>
				</td>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10138'"/>
						<!-- Storage Conditions -->
					</xsl:call-template>
				</td>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10139'"/>
						<!-- Re-test Period -->
					</xsl:call-template>
				</td>
			</tr>
			<xsl:for-each select="//v3:instanceOfKind/v3:productInstance/v3:asContent">
				<tr>
					<td class="formItem">
						<xsl:value-of select="./v3:container/v3:code/@displayName"/>
					</td>
					<td class="formItem">
						<xsl:value-of select="./v3:subjectOf/v3:productEvent/v3:code/@displayName"/>&#160;
						<xsl:value-of select="./v3:subjectOf/v3:productEvent/v3:text"/>
					</td>
					<td class="formItem">
						<xsl:call-template name="string-ISO-date">
							<xsl:with-param name="text" select="../v3:existenceTime"/>
						</xsl:call-template>
					</td>
				</tr>
			</xsl:for-each>
			<tr>
				<td colspan="3" class="formHeadingReg">footer???
				</td>
			</tr>
		</tbody>
		</table>
	</xsl:template>
	<xsl:template name="ProductInfoBasic">
		<tr>
			<td>
				<table width="100%" cellpadding="5" cellspacing="0" class="formTablePetite">
					<tr>
						<td colspan="4" class="formHeadingTitle">
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10066'"/>
								<!-- productInformation -->
							</xsl:call-template>
						</td>
					</tr>
					<tr class="formTableRowAlt">
						<xsl:if test="not(../../v3:part)">
							<td class="formLabel">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10068'"/>
									<!-- productType -->
								</xsl:call-template>
							</td>
							<td class="formItem">
								<xsl:call-template name="hpfb-label"><xsl:with-param name="code" select="v3:templateId[@root='2.16.840.1.113883.2.20.6.53']/@extension"/><xsl:with-param name="codeSystem" select="'2.16.840.1.113883.2.20.6.53'"/></xsl:call-template>
							</td>
						</xsl:if>
						<xsl:for-each select="v3:code[@codeSystem='2.16.840.1.113883.2.20.6.55']">
							<td class="formLabel">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10039'"/>
									<!-- itemCodeSource -->
								</xsl:call-template>
							</td>
							<td class="formItem">
								<xsl:call-template name="hpfb-label"><xsl:with-param name="code" select="./@code"/><xsl:with-param name="codeSystem" select="'2.16.840.1.113883.2.20.6.55'"/></xsl:call-template>
								(<xsl:value-of select="./@code"/>)
							</td>
						</xsl:for-each>
					</tr>
					<xsl:if test="../v3:subjectOf/v3:policy/v3:code/@displayName or  ../v3:consumedIn/*[self::v3:substanceAdministration       or self::v3:substanceAdministration1]/v3:routeCode and not(v3:part)">
						<tr class="formTableRow">
							<xsl:if test="../v3:consumedIn/*[self::v3:substanceAdministration or self::v3:substanceAdministration1]/v3:routeCode and not(v3:part)">
								<td width="30%" class="formLabel">
									<xsl:call-template name="hpfb-title">
										<xsl:with-param name="code" select="'10077'"/>
										<!-- routeOfAdministration -->
									</xsl:call-template>
								</td>
								<td class="formItem" colspan="3">
									<xsl:for-each select="../v3:consumedIn/*[self::v3:substanceAdministration or self::v3:substanceAdministration1]/v3:routeCode">
										<xsl:value-of select="@displayName"/>;&#160;&#160;
									</xsl:for-each>
								</td>
							</xsl:if>
							<xsl:if test="../v3:subjectOf/v3:policy/v3:code/@displayName">
								<td width="30%" class="formLabel">
									<xsl:call-template name="hpfb-title">
										<xsl:with-param name="code" select="'10019'"/>
										<!-- DEA_Schedule -->
									</xsl:call-template>
								</td>
								<td class="formItem">
									<xsl:value-of select="../v3:subjectOf/v3:policy/v3:code/@displayName"/>&#xA0;&#xA0;&#xA0;&#xA0;</td>
							</xsl:if>
						</tr>
					</xsl:if>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="piMedNames">
		<xsl:variable name="medName">
			<xsl:call-template name="string-uppercase">
				<xsl:with-param name="text">
					<xsl:copy>
						<xsl:apply-templates mode="specialCus" select="v3:name"/>
					</xsl:copy>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="genMedName">
			<xsl:call-template name="string-uppercase">
				<xsl:with-param name="text" select="v3:asEntityWithGeneric/v3:genericMedicine/v3:name|v3:asSpecializedKind/v3:generalizedMaterialKind/v3:code[@codeSystem = '2.16.840.1.113883.6.276'  or @codeSystem = '2.16.840.1.113883.6.303']/@displayName"/>
			</xsl:call-template>
		</xsl:variable>

		<tr>
			<td class="contentTableTitle" id="product{count(preceding::v3:manufacturedProduct/v3:manufacturedProduct)}">
				<strong>
					<xsl:value-of select="$medName"/>&#xA0;
					<xsl:call-template name="string-uppercase">
						<xsl:with-param name="text" select="v3:name/v3:suffix"/>
					</xsl:call-template>
				</strong>
				<xsl:apply-templates mode="substance" select="v3:code[@codeSystem = '2.16.840.1.113883.4.9']/@code"/>
				<br/>
				<span class="contentTableReg">
					<xsl:call-template name="string-lowercase">
						<xsl:with-param name="text" select="$genMedName"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="string-lowercase">
						<xsl:with-param name="text" select="v3:formCode/@displayName"/>
					</xsl:call-template>
				</span>
			</td>
		</tr>
	</xsl:template>
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
		<tr>
			<td>
				<xsl:if test="../v3:subjectOf/v3:characteristic">
					<xsl:call-template name="characteristics-new"/>
				</xsl:if>

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
					<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
						<xsl:apply-templates mode="ldd" select="v3:instanceOfKind"/>
					</table>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<xsl:template name="MarketingInfo">
		<xsl:if test="../v3:subjectOf/v3:approval|../v3:subjectOf/v3:marketingAct">
			<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite">
				<tr>
					<td colspan="4" class="formHeadingReg">
						<span class="formHeadingTitle">
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10047'"/>
								<!-- marketingInformation -->
							</xsl:call-template>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="col" class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10045'"/>
							<!-- marketingCategory -->
						</xsl:call-template>
					</th>
					<th scope="col" class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10006'"/>
							<!-- applicationNumberMonographCitation -->
						</xsl:call-template>
					</th>
					<th scope="col" class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10048'"/>
							<!-- marketingStartDate -->
						</xsl:call-template>
					</th>
					<th scope="col" class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10046'"/>
							<!-- marketingEndDate -->
						</xsl:call-template>
					</th>
				</tr>
				<tr class="formTableRowAlt">
					<td class="formItem">
						<xsl:value-of select="../v3:subjectOf/v3:approval/v3:code/@displayName"/>
					</td>
					<td class="formItem">
						<xsl:value-of select="../v3:subjectOf/v3:approval/v3:id/@extension"/>
					</td>
					<td class="formItem">
						<xsl:call-template name="string-ISO-date">
							<xsl:with-param name="text">
								<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:low/@value"/>
							</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="formItem">
						<xsl:call-template name="string-ISO-date">
							<xsl:with-param name="text">
								<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:high/@value"/>
							</xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="equivalentProductInfo">
		<tr>
			<td>
				<table style="font-size:100%" width="100%" cellpadding="3" cellspacing="0" class="contentTablePetite">
					<tbody>
						<tr>
							<th align="left" class="formHeadingTitle">
								<strong>
									<xsl:choose>
										<xsl:when test="v3:ingredient">
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10000'"/>
												<!-- abstractProductConcept -->
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10007'"/>
												<!-- applicationProductConcept -->
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</strong>
							</th>
						</tr>
						<xsl:call-template name="ProductInfoBasic"/>
						<tr>
							<td>
								<xsl:call-template name="ProductInfoIng"></xsl:call-template>
							</td>
						</tr>
						<tr>
							<td class="normalizer">
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
	<xsl:template name="ActiveIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="3" class="formHeadingTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10001'"/>
						<!-- activeIngredientActiveMoiety -->
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10036'"/>
						<!-- ingredientName -->
					</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10009'"/>
						<!-- basisOfStrength -->
					</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10086'"/>
						<!-- strength -->
					</xsl:call-template>
				</th>
			</tr>
			<xsl:if test="not(v3:ingredient[starts-with(@classCode, 'ACTI')]|v3:activeIngredient)">
				<tr>
					<td colspan="3" class="formItem" align="center">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10053'"/>
							<!-- noActiveIngredientsFound -->
						</xsl:call-template>
					</td>
				</tr>
			</xsl:if>
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
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10093'"/>
									<!-- ID -->
								</xsl:call-template>:
								<xsl:value-of select="."/>
								<xsl:if test="position()!=last()">
									<xsl:call-template name="hpfb-title">
										<xsl:with-param name="code" select="'10005'"/>
										<!-- and -->
									</xsl:call-template>
								</xsl:if>
							</xsl:for-each>
							<xsl:text>) </xsl:text>
							<xsl:if test="normalize-space(v3:activeMoiety/v3:activeMoiety/v3:name)">
								<xsl:text> (</xsl:text>
								<xsl:for-each select="v3:activeMoiety/v3:activeMoiety/v3:name">
									<xsl:value-of select="."/>
									<xsl:text> - </xsl:text>
									<xsl:call-template name="hpfb-title">
										<xsl:with-param name="code" select="'10093'"/>
										<!-- UNII -->
									</xsl:call-template>:
									<xsl:value-of select="../v3:code/@code"/>
									<xsl:if test="position()!=last()">,</xsl:if>
								</xsl:for-each>
								<xsl:text>) </xsl:text>
							</xsl:if>
							<xsl:for-each select="../v3:subjectOf/v3:substanceSpecification/v3:code[@codeSystem = '2.16.840.1.113883.6.69' or @codeSystem = '2.16.840.1.113883.3.6277']/@code">(
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10085'"/>
									<!-- sourceNDC -->
								</xsl:call-template>:

								<xsl:value-of select="."/>
								<xsl:text>)</xsl:text>
							</xsl:for-each>
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
						<xsl:value-of select="v3:quantity/v3:numerator/@value"/>&#xA0;<xsl:if test="normalize-space(v3:quantity/v3:numerator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:numerator/@unit"/></xsl:if>
						<xsl:if test="(v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@value)!='1')              or (v3:quantity/v3:denominator/@unit and normalize-space(v3:quantity/v3:denominator/@unit)!='1')">&#xA0;in&#xA0;<xsl:value-of select="v3:quantity/v3:denominator/@value"/>&#xA0;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/></xsl:if></xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="InactiveIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<!-- see PCR 801, just make the header bigger -->
				<td colspan="2" class="formHeadingTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10030'"/>
						<!-- inactiveIngredients -->
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10036'"/>
						<!-- ingredientName -->
					</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10086'"/>
						<!-- strength -->
					</xsl:call-template>
				</th>
			</tr>
			<xsl:if test="not(v3:ingredient[@classCode='IACT']|v3:inactiveIngredient)">
				<tr>
					<td colspan="2" class="formItem" align="center">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10054'"/>
							<!-- noInactiveIngredientsFound -->
						</xsl:call-template>
					</td>
				</tr>
			</xsl:if>
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
							<strong>
								<xsl:value-of select="v3:code/@displayName"/>
							</strong>
							<xsl:text> (</xsl:text>
							<xsl:for-each select="v3:code/@code">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10093'"/>
									<!-- ID -->
								</xsl:call-template>:
								<xsl:value-of select="."/>
							</xsl:for-each>
							<xsl:text>) </xsl:text>
						</td>
					</xsl:for-each>
					<td class="formItem">
						<xsl:value-of select="v3:quantity/v3:numerator/@value"/>&#xA0;<xsl:if test="normalize-space(v3:quantity/v3:numerator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:numerator/@unit"/></xsl:if>
						<xsl:if test="v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@unit)!='1'">&#xA0;in&#xA0;<xsl:value-of select="v3:quantity/v3:denominator/@value"/>&#xA0;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/></xsl:if></xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="otherIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="3" class="formHeadingTitle">
					<xsl:choose>
						<xsl:when test="v3:ingredient[@classCode = 'INGR' or starts-with(@classCode,'ACTI')]">
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10110'"/>
								<!-- other ingredients-->
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10037'"/>
								<!-- ingredients -->
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10035'"/>
						<!-- ingredientKind -->
					</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10036'"/>
						<!-- ingredientName -->
					</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10069'"/>
						<!-- quantity -->
					</xsl:call-template>
				</th>
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
							<xsl:when test="@classCode = 'BASE'">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10008'"/>
									<!-- base -->
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="@classCode = 'ADTV'">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10002'"/>
									<!-- additive -->
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="@classCode = 'CNTM' and v3:quantity/v3:numerator/@value=0">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10021'"/>
									<!-- doesNotContain -->
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="@classCode = 'CNTM'">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10050'"/>
									<!-- mayContain -->
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@classCode"/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<xsl:for-each select="(v3:ingredientSubstance|v3:activeIngredientSubstance)[1]">
						<td class="formItem">
							<strong>
								<xsl:value-of select="v3:code/@displayName"/>
							</strong>
							<xsl:text> (</xsl:text>
							<xsl:for-each select="v3:code/@code">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10093'"/>
									<!-- ID -->
								</xsl:call-template>:
								<xsl:value-of select="."/>
							</xsl:for-each>
							<xsl:text>) </xsl:text>
							<xsl:if test="normalize-space(v3:ingredientSubstance/v3:activeMoiety/v3:activeMoiety/v3:name)">(<xsl:value-of select="v3:ingredientSubstance/v3:activeMoiety/v3:activeMoiety/v3:name"/>)</xsl:if>
						</td>
					</xsl:for-each>
					<td class="formItem">
						<xsl:value-of select="v3:quantity/v3:numerator/@value"/>&#xA0;<xsl:if test="normalize-space(v3:quantity/v3:numerator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:numerator/@unit"/></xsl:if>
						<xsl:if test="v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@unit)!='1'">&#xA0;in&#xA0;<xsl:value-of select="v3:quantity/v3:denominator/@value"/>&#xA0;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/></xsl:if></xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="characteristics-new">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="4" class="formHeadingTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10065'"/>
						<!-- productCharacteristics -->
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10051'"/>
						<!-- Name -->
					</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10100'"/>
					</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10101'"/>
					</xsl:call-template>
				</th>
			</tr>
			<xsl:apply-templates mode="characteristics" select="../v3:subjectOf/v3:characteristic">
			</xsl:apply-templates>
		</table>
	</xsl:template>
	<xsl:template mode="characteristics" match="/|@*|node()">
		<xsl:apply-templates mode="characteristics" select="@*|node()"/>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:characteristic">
		<xsl:variable name="def" select="$characteristics/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue = current()/v3:code/@code]"/>
		<tr>
			<td class="formLabel">
				<xsl:variable name="name" select="$def/../Value[@ColumnRef=$display_language]/SimpleValue"/>
				<xsl:value-of select="$name"/>
				<xsl:if test="not($name)">
					<xsl:text>(</xsl:text>
					<xsl:value-of select="v3:code/@code"/>
					<xsl:text>)</xsl:text>
				</xsl:if>
			</td>
			<xsl:apply-templates mode="characteristics" select="v3:value">
				<xsl:with-param name="def" select="$def"/>
			</xsl:apply-templates>
		</tr>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'ST']">
		<td class="formItem" colspan="2">
			<xsl:value-of select="text()"/>
		</td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'BL']">
		<td class="formItem" colspan="2">
			<xsl:value-of select="@value"/>
		</td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'PQ']">
		<td class="formItem">
			<xsl:value-of select="@value"/>
		</td>
		<td class="formItem">
			<xsl:value-of select="@unit"/>
		</td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'INT']">
		<td class="formItem">
			<xsl:value-of select="@value"/>
		</td>
		<td class="formItem"/>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'CV' or @xsi:type = 'CE' or @xsi:type = 'CE']">
		<td class="formItem">
			<xsl:value-of select=".//@displayName[1]"/>
<!--			<xsl:if test="./v3:originalText">(<xsl:value-of select="./v3:originalText"/>)</xsl:if>-->
			(<xsl:call-template name="hpfb-label"><xsl:with-param name="code" select=".//@code"/><xsl:with-param name="codeSystem" select=".//@codeSystem"/></xsl:call-template>)
		</td>
		<td class="formItem">
			<xsl:value-of select=".//@code[1]"/>
		</td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'REAL']">
		<td class="formItem">
			<xsl:value-of select="@value"/>
		</td>
		<td class="formItem"/>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'IVL_PQ' and v3:high/@unit = v3:low/@unit]" priority="2">
		<td class="formItem">
			<xsl:value-of select="v3:low/@value"/>
			<xsl:text>-</xsl:text>
			<xsl:value-of select="v3:high/@value"/>
		</td>
		<td>
			<xsl:value-of select="v3:low/@unit"/>
		</td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'IVL_PQ' and v3:high/@value and not(v3:low/@value)]">
		<td class="formItem">
			<xsl:text>&lt;</xsl:text>
			<xsl:value-of select="v3:high/@value"/>
		</td>
		<td class="formItem">
			<xsl:value-of select="v3:high/@unit"/>
		</td>
	</xsl:template>
	<xsl:template mode="characteristics" match="v3:value[@xsi:type = 'IVL_PQ' and v3:low/@value and not(v3:high/@value)]">
		<td class="formItem">
			<xsl:text>></xsl:text>
			<xsl:value-of select="v3:low/@value"/>
		</td>
		<td class="formItem">
			<xsl:value-of select="v3:low/@unit"/>
		</td>
	</xsl:template>
	<xsl:template name="packaging">
		<xsl:param name="path" select="."/>
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="5" class="formHeadingTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10059'"/>
						<!-- packaging -->
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<th scope="col" width="1" class="formTitle">#</th>
				<th scope="col" class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10038'"/>
						<!-- itemCode -->
					</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10057'"/>
						<!-- packageDescription -->
					</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10048'"/>
						<!-- marketingStartDate -->
					</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10046'"/>
						<!-- marketingEndDate -->
					</xsl:call-template>
				</th>
			</tr>
			<xsl:for-each select="$path/v3:asContent/descendant-or-self::v3:asContent[not(*/v3:asContent)]">
				<xsl:call-template name="packageInfo">
					<xsl:with-param name="path" select="."/>
					<xsl:with-param name="number" select="position()"/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:if test="not($path/v3:asContent)">
				<tr>
					<td colspan="4" class="formTitle">
						<strong>
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10058'"/>
								<!-- packageInformationNotApplicable -->
							</xsl:call-template>
						</strong>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	<xsl:template name="packageInfo">
		<xsl:param name="path"/>
		<xsl:param name="number" select="1"/>
		<xsl:for-each select="$path/ancestor-or-self::v3:asContent/*[self::v3:containerPackagedProduct or self::v3:containerPackagedMedicine]">
			<xsl:sort select="position()" order="descending"/>
			<xsl:variable name="current" select="."/>
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
					<xsl:variable name="approval" select="current()/../../../v3:subjectOf/v3:approval/v3:code[@codeSystem = $marketing-category-oid]"/>
					<xsl:value-of select="$approval/@displayName"/>(
					<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10093'"/></xsl:call-template>:&#160;
					<xsl:value-of select="$approval/@code"/>)
				</td>
				<td class="formItem">
					<xsl:for-each select="../v3:quantity">
						<xsl:for-each select="v3:numerator">
							<xsl:value-of select="@value"/>
							<xsl:text> </xsl:text>
							<xsl:if test="@unit[. != '1']">
								<xsl:value-of select="@unit"/>
							</xsl:if>
						</xsl:for-each>
						<xsl:text> in </xsl:text>
						<xsl:for-each select="v3:denominator">
							<xsl:value-of select="@value"/>
							<xsl:text> </xsl:text>
						</xsl:for-each>
					</xsl:for-each>
					<xsl:value-of select="v3:formCode/@displayName"/>
					<xsl:for-each select="../v3:subjectOf/v3:characteristic">
						<xsl:text>; </xsl:text>
						<xsl:call-template name="hpfb-label">
							<xsl:with-param name="codeSystem" select="$product-characteristics-oid"/>
							<xsl:with-param name="code" select="current()/v3:code/@code"/>
						</xsl:call-template>
					</xsl:for-each>
				</td>
				<td class="formItem">
					<xsl:call-template name="string-ISO-date">
						<xsl:with-param name="text">
							<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:low/@value"/>
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="formItem">
					<xsl:call-template name="string-ISO-date">
						<xsl:with-param name="text">
							<xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:effectiveTime/v3:high/@value"/>
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="flushSectionTitleFootnotes">
		<xsl:variable name="footnotes" select="./v3:title/v3:footnote[not(ancestor::v3:table)]"/>
		<xsl:if test="$footnotes">
			<hr class="Footnoterule"/>
			<ol class="Footnote">
				<xsl:apply-templates mode="footnote" select="$footnotes"/>
			</ol>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v3:paragraph">
		<!-- Health Canada Change added font size attribute below-->
		<p style="font-size:1.1em;">
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
	<xsl:template match="v3:flushfootnotes" name="flushfootnotes">
		<xsl:variable name="footnotes" select=".//v3:footnote[not(ancestor::v3:table)]"/>
		<xsl:if test="$footnotes">
			<div class="Footnoterule"/>
			<br/>
			<div class="bold">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'10102'"/> <!-- Foot Notes -->
					<!-- additive -->
				</xsl:call-template>:
			</div>
			<ol class="Footnote">
				<xsl:for-each select="$footnotes">
					<li>
						<xsl:value-of select="./text()"/>
					</li>
				</xsl:for-each>
			</ol>
		</xsl:if>
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
				<xsl:when test="$root/v3:document[v3:code/@code = 'X9999-4']">
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
	<xsl:template mode="mixed" match="v3:linkHtml">
		<xsl:element name="a">
			<xsl:attribute name="href"><xsl:value-of select="./@href"/></xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<!-- TABLE MODEL -->
	<!-- Health Canada Change-->
	<xsl:template match="v3:table">
		<!-- see note anchoring and PCR 793 -->
		<xsl:if test="@ID">
			<a name="{@ID}"/>
		</xsl:if>
		<!-- Health Canada Change added attributes for tables-->
		<table width="100%" border="1" style="border:solid 2px;">
			<xsl:apply-templates select="@*|node()"/>
		</table>
	</xsl:template>
	<xsl:template match="v3:table/@summary|v3:table/@width|v3:table/@border|v3:table/@frame|v3:table/@rules|v3:table/@cellspacing|v3:table/@cellpadding">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:thead">
		<thead>
			<xsl:apply-templates select="@*|node()"/>
		</thead>
	</xsl:template>
	<xsl:template match="v3:thead/@align|v3:thead/@char|v3:thead/@charoff|v3:thead/@valign">
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
	<xsl:template match="v3:tfoot/@align|v3:tfoot/@char|v3:tfoot/@charoff|v3:tfoot/@valign">
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
	<xsl:template match="v3:tbody/@align|v3:tbody/@char|v3:tbody/@charoff|v3:tbody/@valign">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="v3:tr">
		<tr style="border-collapse: collapse;">
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode">
					<xsl:choose>
						<xsl:when test="contains(ancestor::v3:table/@styleCode, 'Noautorules') and not(@styleCode)"> <!-- or contains(ancestor::v3:section/v3:code/@code, '43683-2') -->
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
	<xsl:template match="v3:td">
		<!-- determine our position to find out the associated col -->
		<!-- Health Canada Change added attributes for td-->
		<td style="padding:5px; border: solid 1px;">
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</td>
	</xsl:template>
	<xsl:template match="v3:td/@align|v3:td/@char|v3:td/@charoff|v3:td/@valign|v3:td/@abbr|v3:td/@axis|v3:td/@headers|v3:td/@scope|v3:td/@rowspan|v3:td/@colspan">
		<xsl:copy-of select="."/>
	</xsl:template>

	<!-- Health Canada rendering the whole XML doc MAIN MODE based on the deep null-transform -->
	<xsl:template match="@*|node()">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template name="string-uppercase">
		<!--** Convert the input text that is passed in as a parameter to upper case  -->
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
	</xsl:template>
	<xsl:template name="string-lowercase">
		<!--** Convert the input text that is passed in as a parameter to lower case  -->
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
	</xsl:template>
	<xsl:template name="image">
		<xsl:param name="path" select="."/>
		<xsl:if test="string-length($path/v3:value/v3:reference/@value) &gt; 0">
			<img alt="Image of Product" style="width:5%;" src="{$path/v3:value/v3:reference/@value}"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="string-ISO-date">
		<xsl:param name="text"/>
		<xsl:variable name="year" select="substring($text,1,4)"/>
		<xsl:variable name="month" select="substring($text,5,2)"/>
		<xsl:variable name="day" select="substring($text,7,2)"/>
		<xsl:choose>
			<xsl:when test="string-length($text) &gt; 12">
				<xsl:value-of select="concat($year, '-', $month, '-', $day, ' ', substring($text,9,2), ':', substring($text,11,2), ':', substring($text,13,2))"/>
			</xsl:when>
			<xsl:when test="string-length($text) &gt; 8">
				<xsl:value-of select="concat($year, '-', $month, '-', $day, ' ', substring($text,9,2), ':', substring($text,11,2))"/>
			</xsl:when>
			<xsl:when test="string-length($text) &lt; 1">
				<xsl:value-of select="'None'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($year, '-', $month, '-', $day)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
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
					<xsl:message>
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10099'"/>
							<!-- warningMissingRequired -->
						</xsl:call-template>
					</xsl:message>
					<xsl:for-each select="str:tokenize($allCodes, ' ')">
						<xsl:sort select="."/>
						<xsl:copy-of select="."/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="string-length($class) &gt; 0">
				<xsl:attribute name="class">
					<xsl:value-of select="normalize-space($class)"/>
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="string-length($allCodes) &gt; 0">
				<xsl:attribute name="class">
					<xsl:value-of select="normalize-space($allCodes)"/>
				</xsl:attribute>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="additionalStyleAttr">
		<xsl:if test="self::*[self::v3:paragraph]//v3:content[@styleCode[contains(.,'xmChange')]] or v3:content[@styleCode[contains(.,'xmChange')]] and not(ancestor::v3:table)">
			<xsl:attribute name="style">
				<xsl:choose>
					<xsl:when test="self::*//v3:content/@styleCode[contains(.,'xmChange')] or v3:content/@styleCode[contains(.,'xmChange')]">border-left:1px solid;</xsl:when>
					<xsl:otherwise>margin-left:-1em; padding-left:1em; border-left:1px solid;</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>
	<xsl:template name="splitTokens">
		<xsl:param name="text" select="."/>
		<xsl:param name="firstCode" select="substring-before($text,' ')"/>
		<xsl:param name="restOfCodes" select="substring-after($text,' ')"/>
		<xsl:choose>
			<xsl:when test="$firstCode">
				<token value="{concat(translate(substring($firstCode,1,1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($firstCode,2))}"/>
				<xsl:if test="string-length($restOfCodes) &gt; 0">
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
	<xsl:template name="uniqueStyleCodes">
		<xsl:param name="in" select="/.."/>
		<xsl:for-each select="$in/token[not(preceding::token/@value = @value)]">
			<xsl:value-of select="@value"/>
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="showDataWithBR" match="*">
		<xsl:value-of select="."/><xsl:text disable-output-escaping="yes">&lt;br/&gt;</xsl:text>
	</xsl:template>
	<xsl:template name="hpfb-label">
		<xsl:param name="codeSystem" select="/.."/>
		<xsl:param name="code" select="/.."/>
		<xsl:variable name="tempDoc" select="document(concat($oids-base-url,$codeSystem,$file-suffix))"/>
		<xsl:variable name="node" select="$tempDoc/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]"/>
		<xsl:variable name="value" select="$node/../Value[@ColumnRef=$display_language]/SimpleValue"/>
		<xsl:if test="$value"><xsl:value-of select="$value"/></xsl:if>
		<xsl:if test="not($value)">Error: code missing:(<xsl:value-of select="$code"/> in <xsl:value-of select="$codeSystem"/>)</xsl:if>
	</xsl:template>
	<xsl:template name="hpfb-title">
		<xsl:param name="code" select="/.."/>
		<xsl:variable name="node" select="$vocabulary/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]"/>
		<xsl:variable name="value" select="$node/../Value[@ColumnRef=$display_language]/SimpleValue"/>
		<xsl:if test="$value">
			<xsl:value-of select="$value"/>
		</xsl:if>
		<xsl:if test="not($value)">Error: code missing:(<xsl:value-of select="$code"/> in <xsl:value-of select="$section-id-oid"/>)</xsl:if>
	</xsl:template>
	<!-- LIST MODEL -->
	<xsl:template match="v3:list[@styleCode]" priority="1">
		<ul>
			<xsl:apply-templates select="@*|node()"/>
		</ul>
	</xsl:template>
	<xsl:template match="v3:list[@listType='ordered']" priority="2">
		<xsl:apply-templates select="v3:caption"/>
		<ol>
			<xsl:if test="$root/v3:document[v3:code/@code = 'X9999-4']">
				<xsl:attribute name="start">
					<xsl:value-of select="count(preceding-sibling::v3:list/v3:item) + 1"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*|node()[not(self::v3:caption)]"/>
		</ol>
	</xsl:template>
	<xsl:template match="v3:list/v3:item">
		<!-- Health Canada added font size attribute -->
		<li style="font-size:1.1em;">
			<xsl:apply-templates select="@*"/>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</li>
	</xsl:template>
	<xsl:template mode="subjects" match="/|@*|node()">
		<xsl:apply-templates mode="subjects" select="@*|node()"/>
	</xsl:template>
	<!-- DIN info -->
	<xsl:template name="data-contactParty-new">
		<xsl:param name="orgRole" select="/.."/>
			<tr class="formTableRowAlt">
				<td class="formItem">
					<xsl:value-of select="v3:name"/>
				</td>
				<td class="formItem">
					<xsl:value-of select="v3:id[@root='2.16.840.1.113883.2.20.6.31']/@extension"/>
				</td>
				<td class="formItem">
					<xsl:choose>
					<xsl:when test="$orgRole = '0'">
						<xsl:call-template name="formatAddress"><xsl:with-param name="addr" select="v3:contactParty/v3:addr"/></xsl:call-template>
					</xsl:when>
					<xsl:when test="$orgRole = '1'">
						<xsl:call-template name="formatAddress"><xsl:with-param name="addr" select="v3:contactParty/v3:addr"/></xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="formatAddress"><xsl:with-param name="addr" select="v3:addr"/></xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="formItem">
					<xsl:choose>
					<xsl:when test="$orgRole = '0'">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10020'"/>
						<!-- DIN_Owner -->
					</xsl:call-template>
					</xsl:when>
					<xsl:when test="$orgRole = '1'">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10071'"/>
							<!-- registrant -->
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<div style="white-space:nowrap;">
							<xsl:for-each select="../v3:performance/v3:actDefinition/v3:code[@codeSystem=$organization-role-oid]">
								<xsl:if test="position() &gt; 1"><br/></xsl:if>
								<xsl:call-template name="hpfb-label"><xsl:with-param name="code" select="./@code"/><xsl:with-param name="codeSystem" select="$organization-role-oid"/></xsl:call-template>
								<xsl:for-each select="../v3:product">:&#160;&#160;
									<xsl:if test="position() &gt; 1">;&#160;&#160;</xsl:if>
									-&#160;&#160;(<xsl:value-of select="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:code[@codeSystem=$medicinal-product-oids]/@code"/>)
									<xsl:if test="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:templateId">
										&#160;-&#160;
										(<xsl:call-template name="hpfb-label"><xsl:with-param name="code" select="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:templateId[@root=$ingredient-id-oid]/@extension"/><xsl:with-param name="codeSystem" select="$ingredient-id-oid"/></xsl:call-template>&#160;
										(<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10093'"/></xsl:call-template>:&#160;<xsl:value-of select="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:templateId[@root=$ingredient-id-oid]/@extension"/>))
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</div>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
	</xsl:template>
	<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization">
		<xsl:if test="(count(./v3:name)&gt;0)">
			<xsl:call-template name="data-contactParty-new"><xsl:with-param name="orgRole" select="'0'"/></xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization">
		<xsl:if test="./v3:name">
			<xsl:call-template name="data-contactParty-new"><xsl:with-param name="orgRole" select="'1'"/></xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization">
		<xsl:if test="./v3:name">
			<xsl:call-template name="data-contactParty-new"><xsl:with-param name="orgRole" select="'2'"/></xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:transform>
	<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->