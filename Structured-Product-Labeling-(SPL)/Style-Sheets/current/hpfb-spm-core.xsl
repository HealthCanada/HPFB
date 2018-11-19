<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<!--
The contents of this file are subject to the Health Level-7 Public
License Version 1.0 (the "License"); you may not use this file
except in compliance with the License. You may obtain a copy of the
License at http://www.hl7.org/HPL/hpl.txt.

Software distributed under the License is distributed on an "AS IS"
basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
the License for the specific language governing rights and
limitations under the License.

The Original Code is all this file.

The Initial Developer of the Original Code is Gunther Schadow.
Portions created by Initial Developer are Copyright (C) 2002-2013
Health Level Seven, Inc. All Rights Reserved.

Contributor(s): Steven Gitterman, Brian Keller, Brian Suggs, Ian Yang
-->
<!-- Health Canada Change added xmlns:gc-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v3="urn:hl7-org:v3" xmlns:str="http://exslt.org/strings" xmlns:exsl="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="exsl msxsl v3 xsl xsi str">
	<!-- declare the param here for debug use only -->
	<!-- "/.." means the value come from parent or caller parameter -->
	<xsl:param name="show-data" select="/.."/>
	<xsl:param name="oids-base-url" select="/.."/>
	<xsl:param name="show-section-numbers" select="/.."/>
	<xsl:param name="resourcesdir" select="/.."/>
	<xsl:param name="css" select="/.."/>

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
		<xsl:choose>
		<xsl:when test="/v3:document/v3:languageCode/@code = '1'">eng</xsl:when>
		<xsl:otherwise>fra</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="display_language" select="concat('name-',$doc_language)"/>
	<xsl:variable name="doctype" select="/v3:document/v3:code/@code"/>
	<xsl:variable name="file-suffix" select="'.xml'"/>
	<xsl:variable name="codeLookup" select="document(concat($oids-base-url,$structure-aspects-oid,$file-suffix))"/>
	<xsl:variable name="vocabulary" select="document(concat($oids-base-url,$section-id-oid,$file-suffix))"/>
	<xsl:variable name="documentTypes" select="document(concat($oids-base-url,$document-id-oid,$file-suffix))"/>
	<xsl:variable name="characteristics" select="document(concat($oids-base-url,$product-characteristics-oid,$file-suffix))"/>
	<xsl:variable name="jqueryUrl" select="'https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/'"/>
	<xsl:variable name="jqueryUiUrl" select="'https://code.jquery.com/ui/1.12.1/'"/>
	
	<xsl:template name="include-custom-items">
		<script src="{$jqueryUrl}jquery.min.js" type="text/javascript">/*  */</script>
		<script type="text/javascript">/*  */</script>
		<script src="{$jqueryUiUrl}jquery-ui.js" type="text/javascript">/*  */</script>
		<script type="text/javascript">/*  */</script>
		<script src="{$resourcesdir}jqxcore.js" type="text/javascript">/*  */</script>
		<script src="{$resourcesdir}jqxsplitter_spm.js" type="text/javascript">/*  */</script>
		<script src="{$resourcesdir}hpfb-spm.js" type="text/javascript">/*  */</script>
	</xsl:template>
	<xsl:template match="/v3:document/v3:title" priority="1"/>

	<!-- The indication secction variable contains the actual Indication Section node-->
	<xsl:template match="v3:section" mode="tableOfContents">
		<!-- Health Canada Import previous prefix level -->
		<xsl:param name="parentPrefix" select="''"/>
		<xsl:variable name="code" select="v3:code/@code"/>
		<xsl:variable name="sectionID" select="./@ID"/>
		<xsl:variable name="validCode" select="$section-id-oid"/>
		<xsl:variable name="heading" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='level']/SimpleValue"/>

		<!-- Determine most right prefix. -->
		<xsl:variable name="prefix">
			<xsl:choose>
				<!-- Health Canada Heading level 2 nesting can change based on the structure of the XML document. You also have to
					 count the number of siblings in the other sections and then add them. (For example the third element
					 in part #2 needs to also count the number of elements that are in part #1. -->
				<xsl:when test="$heading='2'">
					<xsl:choose>
						<xsl:when test="name(../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])"/>
						</xsl:when>
						<xsl:when test="name(../parent::node())='section'">
							<xsl:value-of select="1 + count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- Health Canada  Heading level 3,4,5 are properly nested and resets for each H2 element.
					 You can simply count the sibling elements to determine the prefix. -->
				<xsl:when test="$heading='3' or $heading='4' or $heading='5'">
					<xsl:value-of select="count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'5'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Health Canada Draw the Heading element only if it should be included in TOC -->
		<xsl:if test="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='include_in_toc' and SimpleValue = 'True']">
			<xsl:choose>
				<!-- Health Canada Heading level 1 (part1,2,3) doesn't have a prefix -->
				<xsl:when test="$heading='1'">
					<h1 id="{$sectionID}h">
						<a href="#{$sectionID}">
							<xsl:call-template name="hpfb-title-resolve"><xsl:with-param name="code" select="$code"/><xsl:with-param name="title" select="v3:title"/></xsl:call-template>
							<xsl:if test="v3:templateId[@root='2.16.840.1.113883.2.20.6.55']">
								&#160;(<xsl:call-template name="hpfb-label"><xsl:with-param name="codeSystem" select="'2.16.840.1.113883.2.20.6.55'"/><xsl:with-param name="code" select="v3:templateId[@root='2.16.840.1.113883.2.20.6.55']/@extension"/></xsl:call-template>
								(<xsl:value-of select="v3:templateId[@root='2.16.840.1.113883.2.20.6.55']/@extension"/>))
							</xsl:if>
							<xsl:if test="v3:templateId[@root='2.16.840.1.113883.2.20.6.56']">
								&#160;(<xsl:call-template name="hpfb-label"><xsl:with-param name="codeSystem" select="'2.16.840.1.113883.2.20.6.56'"/><xsl:with-param name="code" select="v3:templateId[@root='2.16.840.1.113883.2.20.6.56']/@extension"/></xsl:call-template>
								(<xsl:value-of select="v3:templateId[@root='2.16.840.1.113883.2.20.6.56']/@extension"/>))
							</xsl:if>
						</a>
					</h1>
				</xsl:when>
				<!-- Health Canada Heading level 2 doesn't havent any parent prefix -->
				<xsl:when test="$heading='2'">
					<h2 id="{$sectionID}h" style="padding-left:2em;margin-top:1.5ex;">
						<a href="#{$sectionID}">
							<xsl:value-of select="concat($prefix,'. ')"/>
							<xsl:call-template name="hpfb-title-resolve"><xsl:with-param name="code" select="$code"/><xsl:with-param name="title" select="v3:title"/></xsl:call-template>
						</a>
					</h2>
				</xsl:when>
				<xsl:when test="$heading='3'">
					<h3 id="{$sectionID}h" style="padding-left:4.5em;margin-top:1.3ex;">
						<a href="#{$sectionID}">
							<xsl:value-of select="concat($parentPrefix,'.')"/>
							<xsl:value-of select="concat($prefix,' ')"/>
							<xsl:call-template name="hpfb-title-resolve"><xsl:with-param name="code" select="$code"/><xsl:with-param name="title" select="v3:title"/></xsl:call-template>
						</a>
					</h3>
				</xsl:when>
				<xsl:when test="$heading='4'">
					<h4 id="{$sectionID}h" style="padding-left:6em;margin-top:1ex;">
						<a href="#{$sectionID}">
							<xsl:value-of select="concat($parentPrefix,'.')"/>
							<xsl:value-of select="concat($prefix,' ')"/>
							<xsl:call-template name="hpfb-title-resolve"><xsl:with-param name="code" select="$code"/><xsl:with-param name="title" select="v3:title"/></xsl:call-template>
						</a>
					</h4>
				</xsl:when>
				<xsl:when test="$heading='5'">
					<h5 id="{$sectionID}h" style="padding-left:7.5em;margin-top:0.8ex;margin-bottom:0.8ex;">
						<a href="#{$sectionID}">
							<xsl:value-of select="concat($parentPrefix,'.')"/>
							<xsl:value-of select="concat($prefix,' ')"/>
							<xsl:call-template name="hpfb-title-resolve"><xsl:with-param name="code" select="$code"/><xsl:with-param name="title" select="v3:title"/></xsl:call-template>
						</a>
					</h5>
				</xsl:when>
				<xsl:otherwise>Error: <xsl:value-of select="$code"/>/<xsl:value-of select="$heading"/></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:apply-templates select="v3:component/v3:section" mode="tableOfContents">
			<xsl:with-param name="parentPrefix">
				<xsl:choose>
					<xsl:when test="$heading='1' or $heading='2'">
						<xsl:value-of select="$prefix"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($parentPrefix,'.',$prefix)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:apply-templates>
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
				<span class="formHeadingTitle">
					<xsl:apply-templates select="v3:component" mode="tableOfContents"/>
					<xsl:text disable-output-escaping="yes">
						&lt;h1 id=&apos;productDescriptionh&apos;&gt;&lt;a href=&apos;#prodDesc&apos;&gt;
					</xsl:text>
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10000'"/>
						<!-- productDescription -->
					</xsl:call-template>
					<xsl:text disable-output-escaping="yes">&lt;/a&gt;&lt;/h1&gt;</xsl:text>
					<xsl:call-template name="productNames"/>
					<xsl:text disable-output-escaping="yes">
						&lt;h1 id=&apos;organizationsh&apos;&gt;&lt;a href=&apos;#organizations&apos;&gt;
					</xsl:text>
					<xsl:call-template name="hpfb-title">
						<xsl:with-param name="code" select="'10109'"/>
						<!-- Organization -->
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
		<script src="{$jqueryUrl}jquery.min.js" type="text/javascript">/*  */</script>
				<xsl:call-template name="include-custom-items"/>
			</head>
			<body onload="setWatermarkBorder();twoColumnsDisplay();">
				<div class="pageHeader" id="pageHeader">
					<span id="approvedRevisionDateLabel"></span>
					<span id="approvedRevisionDateValue"></span>
					<span id="headerBrandName"></span>
					<span id="pageHeaderTitle"></span>
				</div>
				<div class="contentBody" id="jqxSplitter">
					<div class="leftColumn" id="toc">
						<div id="toc_0999">
							<span onclick="expandCollapseAll(this);">&#xA0;+&#xA0;</span>
							<h1></h1>
						</div>
					</div>
					<div class="spl rightColumn" id="spl">
						<xsl:call-template name="TitlePage"/>
						<div class="pagebreak"/>
						<xsl:apply-templates select="//v3:code[@code='440' and @codeSystem=$section-id-oid]/..">
							<xsl:with-param name="render440" select="'xxx'"/>
						</xsl:apply-templates>
						<div class="pagebreak"/>
						<xsl:apply-templates mode="title" select="."/>
						<div class="Contents">
							<xsl:apply-templates select="@*|node()">
								<xsl:with-param name="render440" select="'440'"/>
							</xsl:apply-templates>
						</div>
						<div class="pagebreak"/>
						<xsl:if test="boolean($show-data)">
							<div class="DataElementsTable">
								<xsl:call-template name="PLRIndications"/>

								<xsl:apply-templates mode="subjects" select="//v3:section/v3:subject/*[self::v3:manufacturedProduct or self::v3:identifiedSubstance]"/>
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
						</xsl:if>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="TitlePage">
		<xsl:variable name="titlePage">
			<xsl:call-template name="hpfb-title">
				<xsl:with-param name="code" select="'10'"/>
				<!-- title page -->
			</xsl:call-template>
		</xsl:variable>
		<div class="titlePage" id="titlePage" tabindex="1">
			<xsl:attribute name="toc">
				<xsl:value-of select="$titlePage"/>
			</xsl:attribute>
			<div class="pageTitle">
				<xsl:value-of select="$documentTypes/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$root/v3:document/v3:code/@code]/../Value[@ColumnRef=$display_language]/SimpleValue"/>
			</div>
			<div class="include">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'10031'"/>
					<!-- IncludePatientMedicationInformation -->
				</xsl:call-template>
			</div>
			<div class="pageTitle" id="pageTitle">
				<xsl:apply-templates mode="mixed" select="$root/v3:document/v3:title"/>
			</div>
			<div class="minSpace"/>
			<div class="minSpace"/>
			<div class="twoColunm">
				<table class="widthFull">
					<tr>
						<td class="borderCellLeft widthHalf">
							<xsl:call-template name="companyAddress"/>
						</td>
						<td class="borderCellLeft verticalTop">
							<span id="approveDate">
								<xsl:attribute name="headerDateLabel">
									<xsl:call-template name="hpfb-title">
										<xsl:with-param name="code" select="'10120'"/>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:attribute name="headerBrandName">
									<xsl:call-template name="hpfb-title">
										<xsl:with-param name="code" select="'10130'"/>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10103'"/>
								</xsl:call-template>:
								<span id="approveDateValue">
									<xsl:call-template name="string-ISO-date">
										<xsl:with-param name="text" select="/v3:document/v3:effectiveTime/v3:originalText"/>
									</xsl:call-template>
								</span>
							</span>
							<br/>
							<br/>
							<span id="revisionDate">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'10105'"/>
								</xsl:call-template>:<span id="revisionDateValue">
								<xsl:call-template name="string-ISO-date">
									<xsl:with-param name="text" select="/v3:document/v3:effectiveTime/@value"/>
								</xsl:call-template></span></span>
						</td>
					</tr>
				</table>
			</div>
			<div class="twoColunm">
				<table style="width:99%; border-spacing: 5px;">
					<xsl:call-template name="assignedOrganization"/>
				</table>
			</div>

			<div class="submissionNumber">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'10015'"/>
				</xsl:call-template>:
				<xsl:for-each select="$root/v3:document/v3:templateId[@root='2.16.840.1.113883.2.20.6.49']">
					<xsl:if test="position() &gt; 1">;&#160;&#160;</xsl:if>
					<xsl:value-of select="./@extension"/>
				</xsl:for-each>
			</div>
			<div class="minSpace"/>
			<div class="minSpace"/>
		</div>
	</xsl:template>
	<xsl:template name="companyAddress">
		<xsl:variable name="organization" select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization"/>
		<p>
			<xsl:value-of select="$organization/v3:name"/>
			<br/>
			<br/>
			<xsl:value-of select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization/v3:contactParty/v3:contactPerson/v3:name"/>
			<br/>
			<br/>
			<xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:streetAddressLine"/>
			<br/>
			<xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:city"/>, <xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:state"/>
			<br/>
			<xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:postalCode"/>
			<br/>
			<xsl:if test="$organization/v3:contactParty/v3:addr/v3:country">
			<xsl:call-template name="hpfb-label">
				<xsl:with-param name="codeSystem" select="$country-code-oid"/>
				<xsl:with-param name="code" select="$organization/v3:contactParty/v3:addr/v3:country/@code"/>
			</xsl:call-template>
			<br/>
			</xsl:if>
		</p>
	</xsl:template>
	<xsl:template name="assignedOrganization">
		<xsl:for-each select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization">
			<tr>
				<td class="borderCellLeft widthHalf">
					<xsl:value-of select="current()/v3:name"/>
				</td>
				<td class="borderCellLeft">
					<xsl:for-each select="../v3:performance/v3:actDefinition/v3:code[@codeSystem=$organization-role-oid]">
						<xsl:if test="position() &gt; 1 " >;&#160;&#160;</xsl:if>
						<xsl:call-template name="hpfb-label">
							<xsl:with-param name="codeSystem" select="$organization-role-oid"/>
							<xsl:with-param name="code" select="./@code"/>
						</xsl:call-template>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!-- Health Canada Change -->
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
			<xsl:if test="$eleSize = '1'">
				<xsl:attribute name="style">font-size:1.1em;</xsl:attribute>
			</xsl:if>
			<xsl:if test="$eleSize = '2'">
				<xsl:attribute name="style">font-size:1em;</xsl:attribute>
			</xsl:if>
			<xsl:if test="$eleSize = '3'">
				<xsl:attribute name="style">font-size:0.9em;</xsl:attribute>
			</xsl:if>

			<!-- Health Canada Change-->
			<!--This code generates the prefix that matches what is shown in the Table of Contents -->
			<xsl:if test="$code != '440' and not($sectionLevel ='1')">
				<xsl:if test="$sectionLevel = 2">
					<!--Health Canada Have to draw 2 -->
					<xsl:choose>
						<xsl:when test="name(../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])"/>
						</xsl:when>
						<xsl:when test="name(../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="'.'"/>
				</xsl:if>
				<xsl:if test="$sectionLevel = 3">
					<!--Health Canada Have to draw 2,3 -->
					<xsl:choose>
						<xsl:when test="name(../../../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])"/>
						</xsl:when>
						<xsl:when test="name(../../../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="concat('.',count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)"/>
				</xsl:if>
				<xsl:if test="$sectionLevel = 4">
					<!--Health Canada Have to draw 2,3,4 -->
					<xsl:choose>
						<xsl:when test="name(../../../../../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])"/>
						</xsl:when>
						<xsl:when test="name(../../../../../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="concat('.',count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)"/>
					<xsl:value-of select="concat('.',count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)"/>
				</xsl:if>
				<xsl:if test="$sectionLevel = 5">
					<!--Health Canada Have to draw 2,3,4,5 -->
					<xsl:choose>
						<xsl:when test="name(../../../../../../../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])"/>
						</xsl:when>
						<xsl:when test="name(../../../../../../../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="concat('.',count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)"/>
					<xsl:value-of select="concat('.',count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)"/>
					<xsl:value-of select="concat('.',count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)"/>
				</xsl:if>
				<xsl:value-of select="' '"/>
			</xsl:if>

			<xsl:apply-templates select="@*"/>

			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template name="footNote">
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<xsl:variable name="code" select="./v3:code/@code"/>
		<!-- Health Canada Added new var, line below-->
		<xsl:variable name="heading" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef=concat($doctype,'-level')]/SimpleValue"/>
		<div class="Section">
			<xsl:for-each select="v3:code">
				<xsl:attribute name="data-sectionCode">
					<xsl:value-of select="@code"/>
				</xsl:attribute>
			</xsl:for-each>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Section'"/>
			</xsl:call-template>
			<!-- Health Canada Changed the below line to get code of section for anchors-->
			<xsl:for-each select="v3:code/@code">
				<a name="{.}"/>
			</xsl:for-each>
			<!-- Health Canada commented this bottom section out to reduce clutter when rendering (inspect element on browser)-->
			<p/>

			<xsl:apply-templates select="v3:title">
				<xsl:with-param name="sectionLevel" select="$heading"/>
				<xsl:with-param name="sectionNumber" select="substring($sectionNumberSequence,2)"/>
			</xsl:apply-templates>
			<xsl:if test="boolean($show-data)">
				<xsl:apply-templates mode="data" select="."/>
			</xsl:if>
			<xsl:apply-templates select="@*|node()[not(self::v3:title)]"/>
			<xsl:call-template name="flushSectionTitleFootnotes"/>
		</div>
	</xsl:template>
	<xsl:template mode="sectionNumber" match="/|@*|node()"/>

	<xsl:template match="v3:section">
		<xsl:param name="sectionLevel" select="count(ancestor-or-self::v3:section)"/>
		<xsl:param name="render440" select="'440'"/>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<xsl:variable name="code" select="v3:code/@code"/>
		<xsl:variable name="sectionID" select="./@ID"/>

		<xsl:variable name="heading" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef='level']/SimpleValue"/>
		<xsl:if test="not ($code='150' or $code='160' or $code='170' or $code=$render440 or $code='520')">
			<xsl:if test="$heading = 1">
				<div class="pagebreak"/>
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
<!--				<xsl:if test="boolean($show-data)">
					<xsl:apply-templates mode="data" select="."/>
				</xsl:if>-->
				<xsl:apply-templates select="@*|node()[not(self::v3:title)]">
					<xsl:with-param name="render440" select="$render440"/>
				</xsl:apply-templates>
				<xsl:call-template name="flushSectionTitleFootnotes"/>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- Start PLR Information templates
			 1. product code
			 2. dosage form
			 3. route of administration
			 4. ingredients
			 5. imprint information
			 6. packaging information
	-->
	<xsl:template name="PLRIndications" mode="indication" match="v3:section [v3:code [descendant-or-self::*  ] ]">
		<xsl:if test="count(//v3:reason) &gt; 0">
			<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%">
				<tbody>
					<tr>
						<td class="contentTableTitle">
							<xsl:call-template name="hpfb-title">
								<xsl:with-param name="code" select="'10034'"/>
								<!--indicationsAndUsage -->
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td>
							<table class="formTablePetite" cellSpacing="0" cellPadding="3" width="100%">
								<tbody>
									<tr>
										<td class="formTitle" colSpan="2">
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10033'"/>
												<!-- indications -->
											</xsl:call-template>
										</td>
										<td class="formTitle" colSpan="4">
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10095'"/>
												<!-- usage -->
											</xsl:call-template>
										</td>
									</tr>
									<tr>
										<td class="formTitle">
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10032'"/>
												<!-- indication -->
											</xsl:call-template>
										</td>
										<td class="formTitle">
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10040'"/>
												<!-- intentOfUse -->
											</xsl:call-template>
										</td>
										<td class="formTitle">
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10049'"/>
												<!-- maximumDose -->
											</xsl:call-template>
										</td>
										<td class="formTitle" colSpan="4">
											<xsl:call-template name="hpfb-title">
												<xsl:with-param name="code" select="'10014'"/>
												<!-- conditionsLimitationsOfUse -->
											</xsl:call-template>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="displayConditionsOfUse">
		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
					<xsl:otherwise>formTableRowAlt</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="./v3:observationCriterion">
					<td class="formItem">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10093'"/>
							<!-- conditionOfUse -->
						</xsl:call-template>
					</td>
					<td class="formItem">
						<xsl:value-of select="./v3:observationCriterion/v3:code/@displayName"/>
					</td>
					<td class="formItem">
						<xsl:apply-templates mode="indication" select="./v3:observationCriterion/v3:value"/>
					</td>
				</xsl:when>
				<xsl:when test="./v3:substanceAdministrationCriterion">
					<td class="formItem">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10093'"/>
							<!-- conditionOfUse -->
						</xsl:call-template>
					</td>
					<td class="formItem">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'10004'"/>
							<!-- adjunct -->
						</xsl:call-template>
					</td>
					<td class="formItem">
						<xsl:value-of select="./v3:substanceAdministrationCriterion/v3:consumable/v3:administrableMaterial/v3:administrableMaterialKind/v3:code/@displayName"/>
					</td>
				</xsl:when>
			</xsl:choose>
			<td class="formItem">
				<xsl:variable name="sectionNumberSequence">
					<xsl:apply-templates mode="sectionNumber" select="ancestor::v3:section[parent::v3:component[parent::v3:structuredBody]]"/>
				</xsl:variable>
				<a href="#section-{substring($sectionNumberSequence,2)}">
					<xsl:value-of select="ancestor::v3:section[parent::v3:component[parent::v3:structuredBody]]/v3:title/text()"/>
				</a>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="printSeperator">
		<xsl:param name="lastDelimiter">
			<xsl:if test="last() &gt; 2">,</xsl:if>&#xA0;<xsl:call-template name="hpfb-title">
				<xsl:with-param name="code" select="'10005'"/>
				<!-- and --></xsl:call-template>&#xA0;</xsl:param>
		<xsl:choose>
			<xsl:when test="position() = last() - 1">
				<xsl:value-of select="$lastDelimiter"/>
			</xsl:when>
			<xsl:when test="position() &lt; last() - 1">,</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="displayLimitationsOfUse">
		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
					<xsl:otherwise>formTableRowAlt</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<td class="formItem">
				<xsl:value-of select="./v3:code/@displayName"/>
			</td>
			<td class="formItem">
				<xsl:for-each select="./v3:subject">
					<xsl:value-of select="./v3:observationCriterion/v3:code/@displayName"/>
					<xsl:call-template name="printSeperator">
						<xsl:with-param name="lastDelimiter">,</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</td>
			<td class="formItem">
				<xsl:for-each select="./v3:subject">
					<xsl:apply-templates mode="indication" select="./v3:observationCriterion/v3:value"/>
					<xsl:call-template name="printSeperator"/>
				</xsl:for-each>
			</td>
			<td class="formItem">
				<xsl:variable name="sectionNumberSequence">
					<xsl:apply-templates mode="sectionNumber" select="ancestor::v3:section[parent::v3:component[parent::v3:structuredBody]]"/>
				</xsl:variable>
				<a href="#section-{substring($sectionNumberSequence,2)}">
					<xsl:value-of select="ancestor::v3:section[parent::v3:component[parent::v3:structuredBody]]/v3:title/text()"/>
				</a>
			</td>
		</tr>
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
	<xsl:template mode="subjects" match="v3:section[v3:code/@code ='48780-1'][not(v3:subject/v3:manufacturedProduct)]/v3:text">
		<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%">
			<tbody>
				<xsl:call-template name="ProductInfoBasic"/>
			</tbody>
		</table>
	</xsl:template>
	<!-- Note: This template is also used for top level Product Concept which does not have v3:asEquivalentEntity -->
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
					</xsl:call-template>&#xA0;&#xA0;<xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'10104'"/>
						<!-- date --></xsl:call-template>:&#xA0;<xsl:call-template name="string-ISO-date"><xsl:with-param name="text"><xsl:value-of select="../v3:subjectOf/v3:marketingAct/v3:code[@codeSystem=$term-status-oid]/../v3:effectiveTime/v3:high/@value"/></xsl:with-param></xsl:call-template></xsl:variable>
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
						<td>
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
	<xsl:template match="v3:text[not(parent::v3:observationMedia)]">
		<!-- Health Canada Change added font size attribute below-->
		<text style="font-size:0.8em;">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
			<xsl:apply-templates mode="rems" select="../v3:subject2[v3:substanceAdministration/v3:componentOf/v3:protocol]"/>
			<xsl:call-template name="flushfootnotes">
				<xsl:with-param name="isTableOfContent" select="'no'"/>
			</xsl:call-template>
		</text>
	</xsl:template>


	<!-- Health Canada Change-->
	<!-- comment added by Brian Suggs on 11-11-05: The flushfootnotes template is called at the end of every section -->
	<!-- MIXED MODE: where text is rendered as is, even if nested
	 inside elements that we do not understand  -->
	<!-- based on the deep null-transform -->
	<xsl:include href="hpfb-common.xsl"/>
</xsl:transform><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="no" externalpreview="yes" url="file:///c:/SPM/test/4.xml" htmlbaseurl="" outputurl="file:///c:/SPM/test/test6.html" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<parameterValue name="oids-base-url" value="'https://raw.githubusercontent.com/HealthCanada/HPFB/master/Controlled-Vocabularies/Content/'"/>
			<parameterValue name="show-section-numbers" value="'1'"/>
			<parameterValue name="show-data" value="'1'"/>
			<parameterValue name="css" value="'https://rawgit.com/IanYangCa/HPFB/master/Structured-Product-Labeling-(SPL)/Style-Sheets/SPM/dev.2/hpfb-spm-core.css'"/>
			<parameterValue name="resourcesdir" value="'C:\IP-602\HPFB\Structured-Product-Labeling-(SPL)\Style-Sheets\dev\'"/>
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