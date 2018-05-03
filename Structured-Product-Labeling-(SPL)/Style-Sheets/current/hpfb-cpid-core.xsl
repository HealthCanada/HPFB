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
	<!-- "/.." means the value come from parent or caller parameter -->
	<xsl:param name="oids-base-url" select="/.."/>
	<xsl:param name="resourcesdir" select="/.."/>
	<xsl:param name="css" select="/.."/>
	<xsl:param name="language" select="/.."/>

	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="no" doctype-public="-"/>
	<xsl:strip-space elements="*"/>

	<xsl:variable name="root" select="/"/>
	<xsl:variable name="section-id-oid" select="'2.16.840.1.113883.2.20.6.8'"/>
	<xsl:variable name="country-code-oid" select="'2.16.840.1.113883.2.20.6.17'"/>
	<xsl:variable name="document-id-oid" select="'2.16.840.1.113883.2.20.6.10'"/>
	<xsl:variable name="marketing-category-oid" select="'2.16.840.1.113883.2.20.6.11'"/>
	<xsl:variable name="ingredient-id-oid" select="'2.16.840.1.113883.2.20.6.14'"/>
	<xsl:variable name="marketing-status-oid" select="'2.16.840.1.113883.2.20.6.18'"/>
	<xsl:variable name="organization-oid" select="'2.16.840.1.113883.2.20.6.31'"/>
	<xsl:variable name="organization-role-oid" select="'2.16.840.1.113883.2.20.6.33'"/>
	<xsl:variable name="pharmaceutical-standard-oid" select="'2.16.840.1.113883.2.20.6.5'"/>
	<xsl:variable name="product-characteristics-oid" select="'2.16.840.1.113883.2.20.6.23'"/>
	<xsl:variable name="structure-aspects-oid" select="'2.16.840.1.113883.2.20.6.36'"/>
	<xsl:variable name="term-status-oid" select="'2.16.840.1.113883.2.20.6.37'"/>
	<xsl:variable name="din-oid" select="'2.16.840.1.113883.2.20.6.42'"/>
	<xsl:variable name="medicinal-product-oids" select="'2.16.840.1.113883.2.20.6.55'"/>

	<xsl:variable name="doc_language">
		<xsl:call-template name="string-lowercase">
			<xsl:with-param name="text">
				<xsl:value-of select="/v3:document/v3:languageCode/@code"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="display_language" select="concat('name-',$doc_language)"/>
	<xsl:variable name="doctype" select="/v3:document/v3:code/@code"/>
	<xsl:variable name="file-suffix" select="'.xml'"/>
	<xsl:variable name="codeLookup" select="document(concat($oids-base-url,$structure-aspects-oid,$file-suffix))"/>
	<xsl:variable name="vocabulary" select="document(concat($oids-base-url,$section-id-oid,$file-suffix))"/>
	<xsl:variable name="documentTypes" select="document(concat($oids-base-url,$document-id-oid,$file-suffix))"/>
	<xsl:variable name="characteristics" select="document(concat($oids-base-url,$product-characteristics-oid,$file-suffix))"/>

	<xsl:template name="include-custom-items">

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script src="{$resourcesdir}jqxcore.js" type="text/javascript" charset="utf-8">/* */</script>
		<script src="{$resourcesdir}jqxsplitter_cpid.js" type="text/javascript" charset="utf-8">/* */</script>
		<script src="{$resourcesdir}hpfb-cpid.js" type="text/javascript" charset="utf-8">/* */</script>
	</xsl:template>
	<!-- Process mixins if they exist -->
	<xsl:template match="/v3:document">
		<html>
			<head>
				<meta name="documentId" content="{/v3:document/v3:id/@root}"/>
				<meta name="documentSetId" content="{/v3:document/v3:setId/@root}"/>
				<meta name="documentVersionNumber" content="{/v3:document/v3:versionNumber/@value}"/>
				<meta name="documentEffectiveTime" content="{/v3:document/v3:effectiveTime/@value}"/>
				<title>
					<!-- GS: this isn't right because the title can have markup -->
					<xsl:value-of select="v3:title"/>
				</title>
				<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
				<link rel="stylesheet" type="text/css" href="{$resourcesdir}jqx.base.css"/>
				<link rel="stylesheet" type="text/css" href="{$css}"/>
				<xsl:call-template name="include-custom-items"/>
			</head>
			<body onload="setWatermarkBorder();twoColumnsDisplay();">
			<div class="cpidHiddenFields">
				<xsl:attribute name="headerDateLabel">
					<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10120'"/></xsl:call-template>
				</xsl:attribute>
				<xsl:attribute name="headerBrandName">
					<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10130'"/></xsl:call-template>
				</xsl:attribute>
			</div>
			<div class="pageHeader" id="pageHeader">
				<table><tbody>
				<tr><td style="white-space:nowrap;"><span id="headerDateLabel">
					<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10120'"/></xsl:call-template>
					</span><span id="headerDateValue">
						<xsl:call-template name="string-ISO-date">
							<xsl:with-param name="text" select="/v3:document/v3:effectiveTime/v3:originalText"/>
						</xsl:call-template>&#160;/
						<xsl:call-template name="string-ISO-date">
							<xsl:with-param name="text" select="/v3:document/v3:effectiveTime/@value"/>
						</xsl:call-template>
					</span>
				</td><td style="white-space:nowrap;"><span id="headerBrandName">
						<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10130'"/></xsl:call-template>
					</span>
				</td><td style="width: 60%;"><div id="pageHeaderTitle"></div>
				</td></tr>
				</tbody></table>
			</div>
			<div class="contentBody" id="jqxSplitter">
				<div class="leftColumn" id="toc">
<!--					<div id="toc_0"><h1 style="background-color:#eff0f1;"><span style="font-weight:bold;" onclick="expandCollapseAll(this);">+&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</span></h1></div>-->
					<div id="toc_0999"><span onclick="expandCollapseAll(this);">&#160;+&#160;</span><h1></h1></div>
				</div>
				<div class="spl rightColumn" id="spl">

					<div class="pagebreak"/>
					<xsl:apply-templates mode="title" select="."/>
					<div id="overviewImage">
						<img alt="Health Canada" src="https://rawgit.com/IanYangCa/HPFB/master/Structured-Product-Labeling-(SPL)/Style-Sheets/dev/Canada_Header.jpg"/>
					</div>
					<div class="Contents">
						<xsl:apply-templates select="./v3:component" />
					</div>
					<div class="pagebreak"/>
					<div class="Contents" id="productInfo">
							<xsl:apply-templates mode="subjects" select="//v3:section/v3:subject/*[self::v3:manufacturedProduct or self::v3:identifiedSubstance]"/>
					</div>
					<div class="Contents" id="organization">
						<table class="contentTablePetite" cellSpacing="0" width="100%" id="organizations">
							<tbody>
								<tr>
									<th align="left" class="formHeadingTitle">
										<strong>
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10109'"/>
												<!-- Organization -->
											</xsl:call-template>
										</strong>
									</th>
								</tr>
								<tr><td>
									<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite" style="font-size:80%" id="organizationId{count(preceding::v3:author/v3:assignedEntity/v3:representedOrganization)}">
										<thead>
										<tr>
											<th scope="col" class="formTitle">
												<xsl:call-template name="hpfb-title">
													<xsl:with-param name="code" select="'10051'"/>
													<!-- name -->
												</xsl:call-template>
											</th>
											<th scope="col" class="formTitle">
												<xsl:call-template name="hpfb-title">
													<xsl:with-param name="code" select="'10027'"/>
													<!-- ID_FEI -->
												</xsl:call-template>
											</th>
											<th scope="col" class="formTitle">
												<xsl:call-template name="hpfb-title">
													<xsl:with-param name="code" select="'10003'"/>
													<!-- address -->
												</xsl:call-template>
											</th>
											<th scope="col" class="formTitle">
												<xsl:call-template name="hpfb-title">
													<xsl:with-param name="code" select="'10121'"/>
													<!-- role -->
												</xsl:call-template>
											</th>
										</tr>
										</thead>
										<tbody>
											<xsl:apply-templates mode="subjects" select="v3:author/v3:assignedEntity/v3:representedOrganization"/>
											<xsl:apply-templates mode="subjects" select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization"/>
											<xsl:apply-templates mode="subjects" select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization"/>
										</tbody>
									</table></td>

								</tr>
							</tbody>
						</table>
					</div>

				</div>
			</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="v3:text[not(parent::v3:observationMedia)]">
		<!-- Health Canada Change added font size attribute below-->
		<xsl:choose>
			<xsl:when test="../v3:code[@code='5056']">
				<xsl:call-template name="overview"/>
			</xsl:when>
			<xsl:when test="../v3:code[@code='5053']">
				<table class="contentTablePetite" cellspacing="0"  width="100%">
				<tbody>
					<tr>
						<td align="left" class="formHeadingTitle"><strong>Organizations</strong></td>
					</tr>
					<xsl:call-template name="manufactures">
						<xsl:with-param name="language" select="$language"/>
					</xsl:call-template>
					<tr>
						<td colspan="4" class="formHeadingReg">footer???
						</td>
					</tr>
				</tbody>
				</table>
			</xsl:when>
			<xsl:when test="../v3:code[@code='5013']">
				<xsl:call-template name="performances"/>
			</xsl:when>
			<xsl:when test="../v3:code[@code='5022']">
				<xsl:call-template name="storageConditions"/>
			</xsl:when>
			<xsl:when test="../v3:code[@code='5031']">
				<table class="contentTablePetite" cellspacing="0" width="100%">
				<tbody>
					<tr>
						<td align="left" class="formHeadingTitle"><strong>Organizations</strong></td>
					</tr>
					<xsl:call-template name="manufactures">
						<xsl:with-param name="index" select="'1'"/>
					</xsl:call-template>
					<tr>
						<td colspan="4" class="formHeadingReg">footer???
						</td>
					</tr>
				</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
				<text style="font-size:0.8em;">
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates mode="mixed" select="node()"/>
					<xsl:apply-templates mode="rems" select="../v3:subject2[v3:substanceAdministration/v3:componentOf/v3:protocol]"/>
					<xsl:call-template name="flushfootnotes">
						<xsl:with-param name="isTableOfContent" select="'no'"/>
					</xsl:call-template>
				</text>
	</xsl:template>
	<xsl:template name="overview">
		<div class="overview">
		<table class="contentTablePetite" cellspacing="0" width="100%">
			<tbody>
				<tr>
					<td colspan="4" id="summaryProducts" class="formHeadingTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10113'"/>
							<!-- SUMMARY OF PRODUCT INFORMATION -->
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10114'"/>
							<!-- Brand Name of Drug Product -->
						</xsl:call-template>
					</td>
					<td class="formItem" colspan="3">
						<xsl:apply-templates mode="showDataWithBR" select="//v3:manufacturedProduct/v3:manufacturedProduct/v3:name"/>
					</td>
				</tr>
				<tr>
					<td class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10115'"/>
							<!-- Non-proprietary (Proper or common name) Name of Drug Product -->
						</xsl:call-template>
					</td>
					<td class="formItem" colspan="3">
						<xsl:apply-templates mode="showDataWithBR" select="//v3:manufacturedProduct/v3:manufacturedProduct/v3:asEntityWithGeneric/v3:genericMedicine/v3:name"/>
					</td>
				</tr>
				<xsl:apply-templates mode="nonProprietarySubstance" select="//v3:manufacturedProduct/v3:manufacturedProduct/v3:ingredient[starts-with(@classCode, 'ACTI')]"/>
				<tr>
					<td class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10117'"/>
							<!-- Company (Manufacturer/Sponsor) Name -->
						</xsl:call-template>
						 
					</td>
					<td class="formItem" colspan="3">
						<xsl:apply-templates mode="showDataWithBR" select="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:name"/>
					</td>
				</tr>
				<tr>
					<td class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10118'"/>
							<!-- Dosage Form(s) -->
						</xsl:call-template>
					</td>
					<td class="formItem" colspan="3">
						<xsl:for-each select="//v3:manufacturedProduct/v3:manufacturedProduct/v3:formCode/@displayName">
							<xsl:value-of select="."/>;&#160;&#160;
						</xsl:for-each>
					</td>
				</tr>
				<tr>
					<td class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10077'"/>
							<!-- Route of Administration -->
						</xsl:call-template>
					</td>
					<td class="formItem" colspan="3">
						<xsl:for-each select="//v3:consumedIn/v3:substanceAdministration/v3:routeCode/@displayName">
							<xsl:value-of select="."/>;&#160;&#160;
						</xsl:for-each>
					</td>
				</tr>
				<tr>
					<td class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10119'"/>
							<!-- Proposed Indication(s) -->
						</xsl:call-template>
					</td>
					<td class="formItem" colspan="3">
					</td>
				</tr>
				<tr>
					<td class="formTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10122'"/>
							<!-- Sponsor’s Date of CPID -->
						</xsl:call-template>
					</td>
					<td class="formItem" colspan="3">
						<xsl:call-template name="string-ISO-date">
							<xsl:with-param name="text" select="/v3:document/v3:effectiveTime/v3:originalText"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="formHeadingReg" colspan="4">
						footer??
					</td>
				</tr>
			</tbody>
		</table>
		<table class="contentTablePetite" cellspacing="0" width="100%">
		<tbody>
			<tr>
				<td colspan="2" id="administrativeSummary" class="formHeadingTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10140'"/>
						<!-- Administrative SUMMARY -->
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10123'"/>
						<!-- DocuBridge Identifier -->
					</xsl:call-template>
				</td>
				<td class="formItem">
					<xsl:value-of select="/v3:document/v3:templateId[@root='2.16.840.1.113883.2.20.6.48']/@extension"/>
				</td>
			</tr>
			<tr>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10124'"/>
						<!-- Control Number -->
					</xsl:call-template>
				</td>
				<td class="formItem">
					<xsl:value-of select="/v3:document/v3:templateId[@root='2.16.840.1.113883.2.20.6.49']/@extension"/>
				</td>
			</tr>
			<tr>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10125'"/>
						<!-- HC Version -->
					</xsl:call-template>
				</td>
				<td class="formItem">
					<xsl:value-of select="/v3:document/v3:versionNumber"/>
				</td>
			</tr>
			<tr>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10126'"/>
						<!-- Date of Acceptance -->
					</xsl:call-template>
				</td>
				<td class="formItem">
					<xsl:call-template name="string-ISO-date">
						<xsl:with-param name="text" select="/v3:document/v3:effectiveTime/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="formItem">Health Canada use only
				</td>
			</tr>
		</tbody>
		</table>
<!--		<div id="topPageFootImage">
			<img alt="Health Canada" src="https://rawgit.com/IanYangCa/HPFB/master/Structured-Product-Labeling-(SPL)/Style-Sheets/dev/Canada.jpg"/>
		</div>-->
		</div>
	</xsl:template>
	<xsl:template mode="nonProprietarySubstance" match="*">
		<tr>
			<td class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'10116'"/>
					<!-- Non-proprietary or Common Name of Drug Substance (Medicinal Ingredient) -->
				</xsl:call-template>
			</td>
			<td class="formItem">
				<xsl:value-of select="./v3:ingredientSubstance/v3:code/@displayName"/>
				(<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10093'"/></xsl:call-template>:&#160;<xsl:value-of select="./v3:ingredientSubstance/v3:code/@code"/>)
			</td>
			<td class="formTitle" style="width:7em;">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'10086'"/>
					<!-- Strength -->
				</xsl:call-template>
			</td>
			<td class="formItem">
				<xsl:value-of select="./v3:quantity/v3:numerator/@value"/>&#160;
				<xsl:value-of select="./v3:quantity/v3:numerator/@unit"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template mode="title" match="/|@*|node()"/>
	<xsl:template mode="title" match="v3:document">
		<div class="DocumentTitle toc" id="tableOfContent">
			<xsl:attribute name="expandCollapse">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'10107'"/>
					<!-- applicationProductConcept -->
				</xsl:call-template>
			</xsl:attribute>
			<p class="DocumentTitle">
						<!-- productDescription 10000 -->
						<!-- Organization 10109 -->
				<span class="formHeadingTitle">
					<xsl:apply-templates select="v3:component" mode="tableOfContents"/>
					<xsl:text disable-output-escaping="yes">
						&lt;h1 id=&#39;productDescriptionh&#39;&gt;&lt;a href=&#39;#prodDesc&#39;&gt;
					</xsl:text>
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10000'"/>
					</xsl:call-template>
					<xsl:text disable-output-escaping="yes">&lt;/a&gt;&lt;/h1&gt;</xsl:text>
					<xsl:call-template name="productNames"/>
					<xsl:text disable-output-escaping="yes">
						&lt;h1 id=&#39;organizationsh&#39;&gt;&lt;a href=&#39;#organizations&#39;&gt;
					</xsl:text>
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10109'"/>
					</xsl:call-template>
					<xsl:text disable-output-escaping="yes">&lt;/a&gt;&lt;/h1&gt;</xsl:text>
				</span>
			</p>
			<xsl:if test="not(//v3:manufacturedProduct) and /v3:document/v3:code/@displayName">
				<xsl:value-of select="/v3:document/v3:code/@displayName"/>
				<br/>
			</xsl:if>
		</div>
	</xsl:template>
	<xsl:template match="v3:title">
		<xsl:param name="sectionLevel" select="count(ancestor::v3:section)"/>
		<xsl:param name="sectionNumber" select="/.."/>

		<xsl:variable name="code" select="../v3:code/@code"/>
		<xsl:variable name="validCode" select="$section-id-oid"/>
		<xsl:variable name="tocObject" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='level']/SimpleValue"/>
		<!-- Health Canada Change Draw H3,H4,H5 elements as H3 because they are too small otherwise -->
		<xsl:variable name="eleSize">
			<xsl:choose>
				<xsl:when test="$sectionLevel &gt; 3">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$sectionLevel = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$sectionLevel">
							<xsl:value-of select="$sectionLevel"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(ancestor::v3:section)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Health Canada Changed variable name to eleSize-->
		<xsl:element name="h{$eleSize}">
			<xsl:value-of select="' '"/>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="manufactures">
		<xsl:variable name="organizations" select="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization"/>
		<xsl:if test="$organizations">
			<tr><td>
<!--			<xsl:variable name="role_name" select="(document(concat($oids-base-url,$organization-role-oid,$file-suffix)))/gc:CodeList/SimpleCodeList/Row[./Value[@ColumnRef='code']/SimpleValue=$index]/Value[@ColumnRef=$display_language]/SimpleValue"/>-->
			<table cellpadding="3" cellspacing="0" class="formTableMorePetite" width="100%">
			<tbody>
			<tr>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10027'"/>
						<!-- Org ID -->
					</xsl:call-template>
				</td>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10051'"/>
						<!-- Org Name -->
					</xsl:call-template>
				</td>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10003'"/>
						<!-- Org Address -->
					</xsl:call-template>
				</td>
				<td class="formTitle">
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10076'"/>
						<!-- Role - Product - Substance -->
					</xsl:call-template>
				</td>
			</tr>
			<xsl:for-each select="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization">
			<xsl:call-template name="manufacture">
				<xsl:with-param name="index" select="position()"/>
			</xsl:call-template>
			</xsl:for-each>

			</tbody>
			</table>
			</td></tr>
		</xsl:if>
<!--		<xsl:if test="$index &lt; 25">
			<xsl:call-template name="manufactures">
				<xsl:with-param name="index" select="$index + 1"/>
			</xsl:call-template>
		</xsl:if>-->
	</xsl:template>
	<xsl:template name="manufacture">
		<xsl:param name="index" select="/.."/>
		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$index mod 2 = 0">formTableRow</xsl:when>
					<xsl:otherwise>formTableRowAlt</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<td class="formItem">
				<xsl:value-of select="./v3:id[@root=$organization-oid]/@extension"/>
			</td>
			<td class="formItem">
				<xsl:value-of select="./v3:name"/>
			</td>
			<td class="formItem">
				<xsl:apply-templates mode="FORMAT" select="./v3:addr"/>
			</td>
			<td class="formItem">
				<xsl:for-each select="../v3:performance">
				<div style="white-space:nowrap;">
				<xsl:value-of select="v3:actDefinition/v3:code[@codeSystem=$organization-role-oid]/@displayName"/>:&#160;
				<xsl:for-each select="v3:actDefinition/v3:product">
					<xsl:if test="position() &gt; 1">
						;&#160;&#160;
					</xsl:if>
					<xsl:value-of select="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:code[@codeSystem=$medicinal-product-oids]/@code"/>
					<xsl:if test="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:templateId">
					&#160;-&#160;
					<xsl:call-template name="hpfb-label"><xsl:with-param name="code" select="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:templateId[@root=$ingredient-id-oid]/@extension"/><xsl:with-param name="codeSystem" select="$ingredient-id-oid"/></xsl:call-template>
					(<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10093'"/><xsl:with-param name="language" select="$language"/></xsl:call-template>:&#160;<xsl:value-of select="v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:templateId[@root=$ingredient-id-oid]/@extension"/>)
					</xsl:if>
				</xsl:for-each>
				</div>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="v3:section" mode="tableOfContents">
		<!-- Health Canada Import previous prefix level -->
		<xsl:param name="parentPrefix" select="''"/>
		<xsl:variable name="code" select="v3:code/@code"/>
		<xsl:variable name="sectionID" select="./@ID"/>
		<xsl:variable name="validCode" select="$section-id-oid"/>
		<xsl:variable name="heading" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='level']/SimpleValue"/>

		<xsl:if test="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='include_in_toc' and SimpleValue = 'True']">
			<xsl:choose>
				<!-- Health Canada Heading level 1 (part1,2,3) doesn't have a prefix -->
				<xsl:when test="$heading='1'">
					<h1 id="{$sectionID}h"><a href="#{$sectionID}"><xsl:value-of select="v3:title"/></a></h1>
			<!--code="5056" codeSystem="2.16.840.1.113883.2.20.6.8"-->
					<xsl:if test="$code = '5056' and $section-id-oid = v3:code/@codeSystem">
						<h2 id="summaryProductsh"><a href="#summaryProducts">
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10113'"/>
							</xsl:call-template>
						</a></h2>
						<h2 id="administrativeSummaryh"><a href="#administrativeSummary">
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10140'"/>
							</xsl:call-template>
						</a></h2>
					</xsl:if>
				</xsl:when>
				<!-- Health Canada Heading level 2 doesn't havent any parent prefix -->
				<xsl:when test="$heading='2'">
					<h2 id="{$sectionID}h" style="padding-left:2em;margin-top:1.5ex;"><a href="#{$sectionID}"><xsl:value-of select="v3:title"/></a></h2>
				</xsl:when>
				<xsl:when test="$heading='3'">
					<h3 id="{$sectionID}h" style="padding-left:4.5em;margin-top:1.3ex;">
						<a href="#{$sectionID}"><xsl:value-of select="v3:title"/></a>
					</h3>
				</xsl:when>
				<xsl:when test="$heading='4'">
					<h4 id="{$sectionID}h" style="padding-left:6em;margin-top:1ex;">
						<a href="#{$sectionID}"><xsl:value-of select="v3:title"/></a>
					</h4>
				</xsl:when>
				<xsl:when test="$heading='5'">
					<h5 id="{$sectionID}h" style="padding-left:7.5em;margin-top:0.8ex;margin-bottom:0.8ex;">
						<a href="#{$sectionID}">
								<xsl:value-of select="v3:title"/>
						</a>
					</h5>
				</xsl:when>
				<xsl:otherwise>Error: <xsl:value-of select="$code"/>/<xsl:value-of select="$heading"/></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:apply-templates select="v3:component/v3:section" mode="tableOfContents">
			<xsl:with-param name="parentPrefix" select="''"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="v3:section">
		<xsl:param name="sectionLevel" select="count(ancestor-or-self::v3:section)"/>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<xsl:variable name="code" select="v3:code/@code"/>
		<xsl:variable name="sectionID" select="./@ID"/>

		<xsl:variable name="heading" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='level']/SimpleValue"/>
		<xsl:if test="not ($code='150' or $code='160' or $code='170' or $code='520')">
			<xsl:if test="$heading = 1">
				<div class="pagebreak" />
			</xsl:if>
			<div class="Section">
				<xsl:attribute name="toc-include">
					<xsl:value-of select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='include_in_toc']/SimpleValue"/>
				</xsl:attribute>
				<xsl:if test="$code = '440'">
					<xsl:attribute name="tabindex">
						<xsl:value-of select="'2'"/>
					</xsl:attribute>
				</xsl:if>
				
				<xsl:for-each select="v3:code">
					<xsl:attribute name="data-sectionCode">
						<xsl:value-of select="$sectionID"/>
					</xsl:attribute>
				</xsl:for-each>
				<xsl:call-template name="styleCodeAttr">
					<xsl:with-param name="styleCode" select="@styleCode"/>
					<xsl:with-param name="additionalStyleCode" select="'Section'"/>
				</xsl:call-template>
				<!-- Health Canada Changed the below line to get code of section for anchors-->
<!--				<xsl:for-each select="v3:code/@code">
					<a name="{.}"/>
				</xsl:for-each>-->
				<a>
					<xsl:attribute name="name">
						<xsl:value-of select="$sectionID"/>
					</xsl:attribute>
				</a>
				<p/>
				<xsl:apply-templates select="v3:title">
					<xsl:with-param name="sectionLevel" select="$heading"/>
					<xsl:with-param name="sectionNumber" select="substring($sectionNumberSequence,2)"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="@*|node()[not(self::v3:title)]" />
				<xsl:call-template name="flushSectionTitleFootnotes"/>
			</div>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="subjects" match="v3:section/v3:subject/v3:manufacturedProduct/*[self::v3:manufacturedProduct[v3:name or v3:formCode] or self::v3:manufacturedMedicine]|v3:section/v3:subject/v3:identifiedSubstance/v3:identifiedSubstance">
		<div class="pagebreak"/>
		<div>
			<xsl:if test="../v3:subjectOf/v3:marketingAct/v3:code[@codeSystem=$term-status-oid]/../v3:effectiveTime/v3:high">
				<xsl:call-template name="styleCodeAttr">
					<xsl:with-param name="styleCode" select="'Watermark'"/>
				</xsl:call-template>
				<xsl:variable name="watermarkText">
					<xsl:call-template name="hpfb-label">
						<xsl:with-param name="codeSystem" select="$term-status-oid"/>
						<xsl:with-param name="code" select="../v3:subjectOf/v3:marketingAct/v3:code[@codeSystem=$term-status-oid]/@code"/>
					</xsl:call-template>&#160;&#160;<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10104'"/><!-- date --></xsl:call-template>:&#160;<xsl:call-template name="string-ISO-date"><xsl:with-param name="text"><xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:code[@codeSystem=$term-status-oid]/../v3:effectiveTime/v3:high/@value"/></xsl:with-param></xsl:call-template>
				</xsl:variable>
				<div class="WatermarkTextStyle">
					<xsl:value-of select="$watermarkText"/>
				</div>
			</xsl:if>
			<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%" id="prodDesc">
				<xsl:if test="../v3:subjectOf/v3:marketingAct/v3:code[@codeSystem=$marketing-status-oid]/../v3:effectiveTime/v3:high">
					<xsl:call-template name="styleCodeAttr">
						<xsl:with-param name="styleCode" select="'contentTablePetite'"/>
						<xsl:with-param name="additionalStyleCode" select="'WatermarkText'"/>
					</xsl:call-template>
				</xsl:if>
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
					<xsl:call-template name="piMedNames"/>
					<xsl:apply-templates mode="substance" select="v3:moiety"/>
					<!--Linkage Table-->
					<xsl:call-template name="ProductInfoBasic"/>
					<!-- Note: there could be a better way to avoid calling this for substances-->
					<xsl:choose>
						<!-- if this is a multi-component subject then call to parts template -->
						<xsl:when test="v3:part">
							<xsl:apply-templates mode="subjects" select="v3:part"/>
							<xsl:call-template name="ProductInfoIng"/>
						</xsl:when>
						<!-- otherwise it is a single product and we simply need to display the ingredients, imprint and packaging. -->
						<xsl:otherwise>
							<xsl:call-template name="ProductInfoIng"/>
						</xsl:otherwise>
					</xsl:choose>

					<tr>
						<td>
							<xsl:call-template name="image">
								<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='2']"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="normalizer">
							<xsl:call-template name="MarketingInfo"/>
						</td>
					</tr>
					<tr>
						<td>
							<xsl:variable name="currCode" select="v3:code/@code"></xsl:variable>
							<xsl:for-each select="ancestor::v3:section[1]/v3:subject/v3:manufacturedProduct/v3:manufacturedProduct[v3:asEquivalentEntity/v3:definingMaterialKind/v3:code/@code = $currCode]">
								<xsl:call-template name="equivalentProductInfo"></xsl:call-template>
							</xsl:for-each>
						</td>
					</tr>
					<xsl:if test="v3:instanceOfKind">
						<tr>
							<td colspan="4">
								<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
									<xsl:apply-templates mode="ldd" select="v3:instanceOfKind"/>
								</table>
							</td>
						</tr>
					</xsl:if>
				</tbody>
			</table>
		</div>
	</xsl:template>
	<xsl:template mode="subjects" match="v3:section[v3:code/@code ='48780-1'][not(v3:subject/v3:manufacturedProduct)]/v3:text">
		<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%">
			<tbody>
				<xsl:call-template name="ProductInfoBasic"/>
			</tbody>
		</table>
	</xsl:template>
	<xsl:include href="hpfb-common.xsl"/>
</xsl:transform><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="CPID" userelativepaths="no" externalpreview="yes" url="file:///e:/CPID-4.xml" htmlbaseurl="" outputurl="file:///c:/SPM/test/cpid.html" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<parameterValue name="oids-base-url" value="'https://raw.githubusercontent.com/HealthCanada/HPFB/master/Controlled-Vocabularies/Content/'"/>
			<parameterValue name="css" value="'file://C:\IP-602\HPFB\Structured-Product-Labeling-(SPL)\Style-Sheets\dev\hpfb-cpid.css'"/>
			<parameterValue name="resourcesdir" value="'file://C:\IP-602\HPFB\Structured-Product-Labeling-(SPL)\Style-Sheets\dev\'"/>
			<parameterValue name="language" value="'eng'"/>
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->