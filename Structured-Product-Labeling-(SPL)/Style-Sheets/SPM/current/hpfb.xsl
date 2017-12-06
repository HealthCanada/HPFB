<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<!--
**************************
@Health Canada:
Jeffrey: This XSL should be able to render all text for the 2004/2016 templates.
We did not receive test files other than the 2004 Standard so I cannot confirm it
it will work 100% without any bugs. From the test files that we did receive,
ALL data from the XMLs are displayed as they are ordered, with all tables
and attributes preserved as well.

The main rendering is done at line 185, which renders the XML tags according to the
XSL:templates available in THIS file.

DONE: Rednering Data, Tables, Numbering, Table of Documents

LAST THING WORKED ON: Section numbering, should be completed
****************************

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

Contributor(s): Steven Gitterman, Brian Keller, Brian Suggs

TODO: footnote styleCode Footnote, Endnote not yet obeyed
TODO: Implementation guide needs to define linkHtml styleCodes.
-->
<!-- Health Canada Change added xmlns:gc-->

<!-- HPFB Changes:
Created a HPFB Variant as there are simply to many small changes 
to try to maintain a single code base, the main reason for this is that the 
labels are not extracted but inline in the code 
-->
<xsl:transform version="1.0"
							 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
							 xmlns:v3="urn:hl7-org:v3"
							 xmlns:v="http://validator.pragmaticdata.com/result"
							 xmlns:str="http://exslt.org/strings"
							 xmlns:exsl="http://exslt.org/common"
							 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
							 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
							 xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
							 exclude-result-prefixes="exsl msxsl v3 xsl xsi str v">
	<xsl:param name="show-data" select="1"/>
	<xsl:param name="root" select="/"/>
	<xsl:param name="css" select="'./spl-hpfb.css'"/>
	<xsl:param name="show-section-numbers" select="/.."/>
	<xsl:param name="resourcesdir" select="'./'" />

	<xsl:param name="vocabulary" select="document('hpfb-labels.xml')"/>

	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="no" doctype-public="-"/>
	<xsl:strip-space elements="*"/>

	<xsl:variable name="section-id-oid" select="'2.16.840.1.113883.2.20.6.8'"/>
	<xsl:variable name="country-code-oid" select="'2.16.840.1.113883.2.20.6.17'"/>
	<xsl:variable name="document-id-oid" select="'2.16.840.1.113883.2.20.6.10'"/>
	<xsl:variable name="marketing-category-oid" select="'2.16.840.1.113883.2.20.6.11'"/>
	<xsl:variable name="ingredient-id-oid" select="'2.16.840.1.113883.2.20.6.14'"/>
	<xsl:variable name="organization-role-oid" select="'2.16.840.1.113883.2.20.6.33'"/>
	<xsl:variable name="pharmaceutical-standard-oid" select="'2.16.840.1.113883.2.20.6.5'"/>
	<xsl:variable name="product-characteristics-oid" select="'2.16.840.1.113883.2.20.6.23'"/>
	<xsl:variable name="structure-aspects-oid" select="'2.16.840.1.113883.2.20.6.36'"/>
	<xsl:variable name="din-oid" select="'2.16.840.1.113883.2.20.6.42'"/>
	<xsl:variable name="dosageAndAdministrationSectionCode">34068-7</xsl:variable>
	<xsl:variable name="indicationSectionCode">34067-9</xsl:variable>

	<!-- pbx: for testng hard code language to eng, later read from docuemnt and convert to lowercase -->
	<xsl:variable name="doc_language">
		<xsl:call-template name="string-lowercase">
			<xsl:with-param name="text">
			 	<xsl:value-of select="/v3:document/v3:languageCode/@code"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="display_language" select="concat('name-',$doc_language)"/>
	<xsl:variable name="doctype" select="/v3:document/v3:code/@code" />
	<xsl:variable name="oid_loc" select="'https://raw.githubusercontent.com/HealthCanada/HPFB/master/Controlled-Vocabularies/Content/'"/>
	<xsl:variable name="file-prefix" select="'hpfb-'"/>
	<xsl:variable name="file-suffix" select="'.gc.xml'"/>
	<xsl:variable name="codeLookup" select="document(concat($oid_loc,$file-prefix,$structure-aspects-oid,$file-suffix))"/>
	<!-- Process mixins if they exist -->
	<xsl:template match="/" priority="1">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:variable name="documentTypes" select="document(concat($oid_loc,$file-prefix,$document-id-oid,$file-suffix))"/>
	<xsl:variable name="characteristics" select="document(concat($oid_loc,$file-prefix,$product-characteristics-oid,$file-suffix))"/>

	<!-- Health Canada rendering the whole XML doc MAIN MODE based on the deep null-transform -->
	<xsl:template match="@*|node()">
			<xsl:apply-templates select="*"/>
	</xsl:template>
	<!-- GS: the document title should not be processed in normal mode.
			 This is really should be revisited when the top-level template gets refactored. -->
	<xsl:template match="/v3:document/v3:title" priority="1"/>

	<!-- The indication secction variable contains the actual Indication Section node-->
	<xsl:variable name="indicationSection" select="/v3:document/v3:component/v3:structuredBody/v3:component//v3:section [v3:code [descendant-or-self::* [(self::v3:code or self::v3:translation) and @codeSystem='2.16.840.1.113883.6.1'] ] ]"/>
	<xsl:template match="v3:section" mode="tableOfContents">
		<!-- Health Canada Import previous prefix level -->
		<xsl:param name="parentPrefix" select="''" />
		<xsl:variable name="code" select="v3:code/@code" />
		<xsl:variable name="validCode" select="$section-id-oid" />
		<!-- Health Canada Lookup whether CODE is included in Table of Contents and find Heading level -->
		<xsl:variable name="included" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef=concat($doctype,'-toc')]/SimpleValue" />
		<xsl:variable name="heading" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef=concat($doctype,'-level')]/SimpleValue" />
		<!-- Determine most right prefix. -->
		<xsl:variable name="prefix">
			<xsl:choose>
				<!-- Health Canada Heading level 2 nesting can change based on the structure of the XML document. You also have to
					 count the number of siblings in the other sections and then add them. (For example the third element
					 in part #2 needs to also count the number of elements that are in part #1. -->
				<xsl:when test="$heading='2'">
					<xsl:choose>
						<xsl:when test="name(../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])" />
						</xsl:when>
						<xsl:when test="name(../parent::node())='section'">
							<xsl:value-of select="1 + count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- Health Canada  Heading level 3,4,5 are properly nested and resets for each H2 element.
					 You can simply count the sibling elements to determine the prefix. -->
				<xsl:when test="$heading='3' or $heading='4' or $heading='5'">
					<xsl:value-of select="count(../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1" />
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<!-- Health Canada Draw the Heading element only if it should be included in TOC -->
		<xsl:if test="$included='T'">
			<xsl:choose>
				<!-- Health Canada Heading level 1 (part1,2,3) doesn't have a prefix -->
				<xsl:when test="$heading='1'">
					<a href="#{$code}"><h1 id="{$code}h" style="text-transform:uppercase; font-size:1.5em;">
						<xsl:value-of select="v3:title" />
					</h1></a>
				</xsl:when>
				<!-- Health Canada Heading level 2 doesn't havent any parent prefix -->
				<xsl:when test="$heading='2'">
					<a href="#{$code}"><h2 id="{$code}h" style="text-transform:uppercase;padding-left:2em;margin-top:1.5ex;font-size:1.4em;">
						<xsl:value-of select="concat($prefix,'. ')" />
						<xsl:value-of select="v3:title" />
					</h2></a>
				</xsl:when>
				<!-- Health Canada  Heading level 3,4,5 you concatenate the parent prefix with the prefix -->
				<xsl:when test="$heading='3'">
					<a href="#{$code}"><h3 id="{$code}h" style="padding-left:4.5em;margin-top:1.3ex;font-size:1.3em;">
						<xsl:value-of select="concat($parentPrefix,'.')" />
						<xsl:value-of select="concat($prefix,' ')" />
						<xsl:value-of select="v3:title" />
					</h3></a>
				</xsl:when>
				<xsl:when test="$heading='4'">
					<a href="#{$code}"><h4 id="{$code}h" style="padding-left:6em;margin-top:1ex;font-size:1.2em;">
						<xsl:value-of select="concat($parentPrefix,'.')" />
						<xsl:value-of select="concat($prefix,' ')" />
						<xsl:value-of select="v3:title" />
					</h4></a>
				</xsl:when>
				<xsl:when test="$heading='5'">
					<a href="#{$code}"><h5 id="{$code}h" style="padding-left:7.5em;margin-top:0.8ex;margin-bottom:0.8ex;font-size:1.1em;">
						<xsl:value-of select="concat($parentPrefix,'.')" />
						<xsl:value-of select="concat($prefix,' ')" />
						<xsl:value-of select="v3:title" />
					</h5></a>
				</xsl:when>
				<xsl:otherwise>
					Error: <xsl:value-of select="$code" />/<xsl:value-of select="$heading" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<!--Health Canada Call the template for the subsequent sections -->
		<xsl:apply-templates select="v3:component/v3:section" mode="tableOfContents">
			<xsl:with-param name="parentPrefix">
				<!--Health Canada  Send the rendered prefix down to nested elements. -->
				<xsl:choose>
					<xsl:when test="$heading='1' or $heading='2'">
						<xsl:value-of select="$prefix" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($parentPrefix,'.',$prefix)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template mode="title" match="v3:document">
		<div class="DocumentTitle">
			<p class="DocumentTitle">
					<xsl:value-of select="/v3:document/v3:code/@displayName"/>
					<br/>
				<!-- Health Canada Added these 3 lines to render the ToC-->
				<span class='formHeadingTitle'>
					<xsl:apply-templates select="v3:component" mode="tableOfContents" />
				</span>
			</p>

			<xsl:variable name="marketingCategories" select="//v3:manufacturedProduct/v3:subjectOf/v3:approval/v3:code"/>
			<xsl:if test="not(//v3:manufacturedProduct) and /v3:document/v3:code/@displayName">
				<xsl:value-of select="/v3:document/v3:code/@displayName"/>
				<br/>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- DOCUMENT MODEL -->
	<xsl:template mode="title" match="/|@*|node()"/>
	<xsl:template mode="title" match="v3:document">
		<div class="DocumentTitle">
			<p class="DocumentTitle">
				<!-- Health Canada Title Page -->
				<!-- Health Canada Added these 3 lines to render the ToC-->
				<span class='formHeadingTitle'>
					<xsl:apply-templates select="v3:component" mode="tableOfContents" />
				</span>
			</p>
			<xsl:if test="not(//v3:manufacturedProduct) and /v3:document/v3:code/@displayName">
				<xsl:value-of select="/v3:document/v3:code/@displayName"/>
				<br/>
			</xsl:if>
		</div>
	</xsl:template>
	<xsl:template match="/v3:document">
		<!-- GS: this template needs thorough refactoring -->
		<html>
			<head>
				<meta name="documentId" content="{/v3:document/v3:id/@root}"/>
				<meta name="documentSetId" content="{/v3:document/v3:setId/@root}"/>
				<meta name="documentVersionNumber" content="{/v3:document/v3:versionNumber/@value}"/>
				<meta name="documentEffectiveTime" content="{/v3:document/v3:effectiveTime/@value}"/>
				<title><!-- GS: this isn't right because the title can have markup -->
					<xsl:value-of select="v3:title"/>
				</title>
				<link rel="stylesheet" type="text/css" href="{$css}"/>
				<xsl:call-template name="include-custom-items"/>
			</head>
			<body class="spl" id="spl">
				<xsl:attribute name="onload"><xsl:text>if(typeof convertToTwoColumns == "function")convertToTwoColumns();</xsl:text></xsl:attribute>
				<!-- Health Canada Generate Title Page -->
				<xsl:call-template name="TitlePage"/>
				<xsl:apply-templates mode="title" select="."/>
				<xsl:choose>
					<xsl:when test="//v3:excerpt/v3:highlight">
						<xsl:variable name="highlightsRtf">
							<xsl:apply-templates mode="highlights" select="."/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="function-available('exsl:node-set')">
								<xsl:apply-templates mode="twocolumn" select="exsl:node-set($highlightsRtf)">
									<xsl:with-param name="class">Highlights</xsl:with-param>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:when test="function-available('msxsl:node-set')">
								<xsl:apply-templates mode="twocolumn" select="msxsl:node-set($highlightsRtf)">
									<xsl:with-param name="class">Highlights</xsl:with-param>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message terminate="yes">required function node-set is not available, this XSLT processor cannot handle the transform</xsl:message>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Generate the Table of Contents only if the SPL is PLR. -->
						<xsl:variable name="indexRtf">
							<xsl:apply-templates mode="index" select="."/>
						</xsl:variable>
						<!-- FDA TOP OF CONTENT -->
					</xsl:when>
					<xsl:otherwise>
						<h1 id="H1ID"><xsl:apply-templates mode="mixed" select="v3:title"/></h1>
					</xsl:otherwise>
				</xsl:choose>
				<div class="Contents">
					<xsl:apply-templates select="@*|node()[not(self::v3:relatedDocument[@typeCode = 'DRIV' or @typeCode = 'RPLC'])]"/>
				</div>
				<xsl:if test="boolean($show-data)">
					<div class="DataElementsTable">
						<!-- HPFB: pbx: re-enabled the Product Data aspect --> 
							<xsl:call-template name="PLRIndications"/>

						<xsl:if test="//v3:*[self::v3:ingredientSubstance[starts-with(../@classCode,'ACTI')] ]">
							<xsl:call-template name="PharmacologicalClass"/>
						</xsl:if>
						<xsl:apply-templates mode="subjects" select="//v3:section/v3:subject/*[self::v3:manufacturedProduct or self::v3:identifiedSubstance]"/>
						<xsl:apply-templates mode="subjects" select="v3:author/v3:assignedEntity/v3:representedOrganization"/>
						<xsl:apply-templates mode="subjects" select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization"/>
						<xsl:apply-templates mode="subjects" select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization"/>
					<!-- End of comment-->
					</div>
				</xsl:if>
				<xsl:apply-templates select="v3:relatedDocument[/v3:document/v3:code[@code = 'X9999-4']][@typeCode = 'RPLC']"/>
				<p>
					<xsl:call-template name="effectiveDate"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:call-template name="distributorName"/>
				</p>

			</body>
		</html>
	</xsl:template>
	<xsl:template name="TitlePage">
		<xsl:variable name='titleNode' select="/descendant-or-self::*[@code='450' and @codeSystem=$section-id-oid]" />
		<div class="titlePage">
			<div class="pageTitle">
				<xsl:value-of select="$titleNode/../v3:code/@displayName"/>
			</div>
			<div class="productName">
				<xsl:value-of select="/descendant-or-self::*[@code='48780-1' and @codeSystem=$section-id-oid]/../v3:subject/v3:manufacturedProduct/v3:manufacturedProduct/v3:asEntityWithGeneric/*/v3:name"/>
			</div>
			<div class="author">
				<xsl:value-of select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization/v3:contactParty/v3:contactPerson/v3:name"/>
			</div>
			<div class="productDesc">
				<p>
				Product Description
				</p>
			</div>
			<div class="twoColunm">
				<div class="rightColunm">
					<div class="date">
						<xsl:call-template name="hpfb-label">
							<xsl:with-param name="codeSystem" select="$section-id-oid"/>
							<xsl:with-param name="code" select="'150'"/>
						</xsl:call-template> :
						<xsl:value-of select="/descendant-or-self::*[@code='150' and @codeSystem=$section-id-oid]/../v3:text"/>
					</div>
					<div class="date">
						<xsl:call-template name="hpfb-label">
							<xsl:with-param name="codeSystem" select="$section-id-oid"/>
							<xsl:with-param name="code" select="'160'"/>
						</xsl:call-template> :
						<xsl:value-of select="/descendant-or-self::*[@code='160' and @codeSystem=$section-id-oid]/../v3:text"/>
					</div>
				</div>
				<div class="leftColunm">
					<xsl:call-template name="companyAddress"/>
					<div class="companyWebsite">
						company web site
					</div>
				</div>
			</div>
			<div class="submissionNumber">
				<xsl:call-template name="hpfb-label">
					<xsl:with-param name="codeSystem" select="$section-id-oid"/>
					<xsl:with-param name="code" select="'170'"/>
				</xsl:call-template> :
				<xsl:value-of select="/descendant-or-self::*[@code='170' and @codeSystem=$section-id-oid]/../v3:text"/>
			</div>
			<div class="companyRight">
			ZOLADEX®is a registered trademark of the AstraZeneca group of companies.
			</div>
		</div>
	</xsl:template>
	<xsl:template name="companyAddress">
		<xsl:variable name="organization" select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization"/>
		<div class="address">
			<p>
			<xsl:value-of select="$organization/v3:name"/>
			<br/><xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:streetAddressLine"/>
			<br/><xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:city"/>, <xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:state"/>
			<br/><xsl:value-of select="$organization/v3:contactParty/v3:addr/v3:postalCode"/>
			<br/>
				<xsl:call-template name="hpfb-label">
					<xsl:with-param name="codeSystem" select="$country-code-oid"/>
					<xsl:with-param name="code" select="$organization/v3:contactParty/v3:addr/v3:country/@code"/>
				</xsl:call-template>
				<br/>
			</p>
		</div>
	</xsl:template>
	<!-- Health Canada Change -->
	<xsl:template match="v3:title">
		<xsl:param name="sectionLevel" select="count(ancestor::v3:section)"/>
		<xsl:param name="sectionNumber" select="/.."/>

		<xsl:variable name="code" select="../v3:code/@code" />
		<xsl:variable name="validCode" select="$section-id-oid" />
		<xsl:variable name="tocObject" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef=concat($doctype,'-toc')]/SimpleValue" />
		<!-- Health Canada Change Draw H3,H4,H5 elements as H3 because they are too small otherwise -->
		<xsl:variable name="eleSize"><xsl:choose><xsl:when test="$sectionLevel > 3"><xsl:value-of select="'3'" /></xsl:when><xsl:otherwise><xsl:value-of select="$sectionLevel" /></xsl:otherwise></xsl:choose>
		</xsl:variable>

		<!-- Health Canada Changed variable name to eleSize-->
		<xsl:element name="h{$eleSize}">
			<xsl:if test="$eleSize = '1'">
				<xsl:attribute name="style">font-size:1.5em;</xsl:attribute>
			</xsl:if>
			<xsl:if test="$eleSize = '2'">
				<xsl:attribute name="style">font-size:1.3em;</xsl:attribute>
			</xsl:if>
			<xsl:if test="$eleSize = '3'">
				<xsl:attribute name="style">font-size:1.2em;</xsl:attribute>
			</xsl:if>

			<!-- Health Canada Change-->
			<!--This code generates the prefix that matches what is shown in the Table of Contents -->
			<xsl:if test="$tocObject = 'T' and not($sectionLevel ='1')">
				<xsl:if test="$sectionLevel = 2">
				<!--Health Canada Have to draw 2 -->
					<xsl:choose>
						<xsl:when test="name(../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])" />
						</xsl:when>
						<xsl:when test="name(../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])" />
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="'.'" />
				</xsl:if>
				<xsl:if test="$sectionLevel = 3" >
				<!--Health Canada Have to draw 2,3 -->
					<xsl:choose>
						<xsl:when test="name(../../../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])" />
						</xsl:when>
						<xsl:when test="name(../../../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])" />
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="concat('.',count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)" />
				</xsl:if>
				<xsl:if test="$sectionLevel = 4" >
				<!--Health Canada Have to draw 2,3,4 -->
					<xsl:choose>
						<xsl:when test="name(../../../../../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])" />
						</xsl:when>
						<xsl:when test="name(../../../../../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])" />
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="concat('.',count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)" />
					<xsl:value-of select="concat('.',count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)" />
				</xsl:if>
				<xsl:if test="$sectionLevel = 5" >
				<!--Health Canada Have to draw 2,3,4,5 -->
					<xsl:choose>
						<xsl:when test="name(../../../../../../../../parent::node())='structuredBody'">
							<xsl:value-of select="1 + count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) - count($root/v3:document/v3:component/v3:structuredBody/v3:component[v3:section/v3:code[@code=20]]/preceding-sibling::*) - count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='30' or @code='40' or @code='480']])" />
						</xsl:when>
						<xsl:when test="name(../../../../../../../../parent::node())='section'">
							<xsl:value-of select="1 + count(../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + count(../../../../../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@code='20' or @code='30' or @code='40']]/v3:section/child::v3:component[v3:section/v3:code[@codeSystem=$validCode]])" />
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="concat('.',count(../../../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)" />
					<xsl:value-of select="concat('.',count(../../../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)" />
					<xsl:value-of select="concat('.',count(../../preceding-sibling::v3:component[v3:section/v3:code[@codeSystem=$validCode]]) + 1)" />
				</xsl:if>
				 <xsl:value-of select="' '" />
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
<!-- Health Canada Change-->
	<xsl:template match="v3:section">
		<xsl:param name="sectionLevel" select="count(ancestor-or-self::v3:section)"/>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<xsl:variable name="code" select="v3:code/@code" />
		<!-- Health Canada Added new var, line below-->
		<xsl:variable name="heading" select="$codeLookup/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]/../Value[@ColumnRef=concat($doctype,'-level')]/SimpleValue" />
			<div class="Section">
				<xsl:for-each select="v3:code">
					<xsl:attribute name="data-sectionCode"><xsl:value-of select="@code"/></xsl:attribute>
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
				<!--<a name="section-{substring($sectionNumberSequence,2)}"/>-->
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
	<xsl:template match="v3:section[v3:code[descendant-or-self::*[self::v3:code or self::v3:translation][@codeSystem='2.16.840.1.113883.6.1' and @code='34066-1']]]" priority="2">
		<!-- boxed warning -->
		<xsl:param name="sectionLevel" select="count(ancestor-or-self::v3:section)"/>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>

		<div>
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Warning'"/>
			</xsl:call-template>
			<xsl:for-each select="@ID">
				<a name="{.}"/>
			</xsl:for-each>
			<a name="section-{substring($sectionNumberSequence,2)}"/>
			<p/>
			<!-- this funny p is used to prevent melting two sub-sections together in condensed style -->
			<xsl:apply-templates select="v3:title">
				<xsl:with-param name="sectionLevel" select="$sectionLevel"/>
				<xsl:with-param name="sectionNumber" select="substring($sectionNumberSequence,2)"/>
			</xsl:apply-templates>

			<xsl:apply-templates select="@*|node()[not(self::v3:title)]"/>
		</div>
	</xsl:template>
	<xsl:template name="include-custom-items">
		<script src="{$resourcesdir}spl.js" type="text/javascript" charset="utf-8">/* */</script>
	</xsl:template>
<!-- Start PLR Information templates
			 1. product code
			 2. dosage form
			 3. route of administration
			 4. ingredients
			 5. imprint information
			 6. packaging information
	-->
<xsl:template name="PLRIndications" mode="indication" match="v3:section [v3:code [descendant-or-self::* [(self::v3:code or self::v3:translation) and @codeSystem='2.16.840.1.113883.6.1'] ] ]">
	<xsl:if test="count(//v3:reason) > 0">
		<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%">
			<tbody>
				<tr>
					<td class="contentTableTitle">
						<xsl:call-template name="hpfb-title">
							<xsl:with-param name="code" select="'indicationsAndUsage'"/>
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
											<xsl:with-param name="code" select="'indications'"/>
										</xsl:call-template>
									</td>
									<td class="formTitle" colSpan="4">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'usage'"/>
										</xsl:call-template>
									</td>
								</tr>
								<tr>
									<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'indication'"/>
										</xsl:call-template>
									</td>
									<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'intentOfUse'"/>
										</xsl:call-template>
									</td>
									<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'maximumDose'"/>
										</xsl:call-template>
									</td>
									<td class="formTitle" colSpan="4">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'conditionsLimitationsOfUse'"/>
										</xsl:call-template>
									</td>
								</tr>
								<!-- Repeat Me -->
								<xsl:for-each select="$indicationSection//v3:excerpt/v3:highlight/v3:subject">
									<tr class="formTableRowAlt">
										<td class="formItem" valign="top">
											<strong><xsl:value-of select="./v3:substanceAdministration/v3:reason/v3:indicationObservationCriterion/v3:value/@displayName"/> (<xsl:value-of
												select="./v3:substanceAdministration/v3:reason/v3:indicationObservationCriterion/v3:code/@displayName"/>)</strong>
										</td>
										<td class="formItem" valign="top">
											<xsl:value-of select="./v3:substanceAdministration/v3:reason/@typeCode"/>
										</td>
										<td class="formItem" valign="top">
											<xsl:choose>
												<xsl:when test="./v3:substanceAdministration/v3:maxDoseQuantity">
													<xsl:value-of select="./v3:substanceAdministration/v3:maxDoseQuantity/v3:numerator/@value"/>&#160; <xsl:value-of
														select="./v3:substanceAdministration/v3:maxDoseQuantity/v3:numerator/@unit"/>&#160;per&#160; <xsl:value-of
														select="./v3:substanceAdministration/v3:maxDoseQuantity/v3:denominator/@value"/>&#160; <xsl:value-of
														select="./v3:substanceAdministration/v3:maxDoseQuantity/v3:denominator/@unit"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:for-each select="//v3:maxDoseQuantity[ancestor::v3:section/v3:code/@code = $dosageAndAdministrationSectionCode]">
														<xsl:value-of select="./v3:numerator/@value"/>&#160; <xsl:value-of select="./v3:numerator/@unit"/>&#160;per&#160; <xsl:value-of
															select="./v3:denominator/@value"/>&#160; <xsl:value-of select="./v3:denominator/@unit"/>
													</xsl:for-each>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td class="formItem" colSpan="3">
											<table class="formTablePetite" cellSpacing="0" cellPadding="5" width="100%">
												<tbody>
													<tr class="formTable">
														<td class="formTitle" colSpan="4">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'conditionsOfUse'"/>
										</xsl:call-template>
														</td>
													</tr>
													<tr class="formTable">
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'useCategory'"/>
										</xsl:call-template>
														</td>
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'preconditionCategory'"/>
										</xsl:call-template>
														</td>
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'precondition'"/>
										</xsl:call-template>
														</td>
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'labelingSection'"/>
										</xsl:call-template>
														</td>
													</tr>
													<!-- Repeat Each precondition for the indication subject -->
													<!-- PCR 593 Displaying all the preconditions that are specifict to this indication and those that may be in other sections such
																 as the Dosage forms and Strengths.
														-->
													<!-- PCR 593 Displaying all the preconditions that are specifict to this indication and those that may be in other sections such
																 as the Dosage forms and Strengths.
														-->
													<!-- PCR 606 In order to remove the duplicates each section whose ancestor is anything other than $indicationSectionCode.
																 A not (!) in the predicate will not do since a precondition axis can have multiple section tags as ancestors, of which any may be an Indication Section.
														-->
													<xsl:for-each select="./v3:substanceAdministration/v3:precondition">
														<xsl:call-template name="displayConditionsOfUse"> </xsl:call-template>
													</xsl:for-each>
													<xsl:for-each select="//v3:excerpt/v3:highlight/v3:subject/v3:substanceAdministration/v3:precondition">
														<xsl:if test="count(ancestor::v3:section[v3:code/@code=$indicationSectionCode]) = 0">
															<xsl:call-template name="displayConditionsOfUse"> </xsl:call-template>
														</xsl:if>
													</xsl:for-each>
													<xsl:for-each select="./v3:substanceAdministration/v3:componentOf">
														<tr>
															<xsl:attribute name="class">
																<xsl:choose>
																	<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
																	<xsl:otherwise>formTableRowAlt</xsl:otherwise>
																</xsl:choose>
															</xsl:attribute>
															<td class="formItem">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'conditionOfUse'"/>
										</xsl:call-template>
															</td>
															<td class="formItem">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'screeningMonitoringTest'"/>
										</xsl:call-template>
															</td>
															<td class="formItem">
																<xsl:for-each select="./v3:protocol/v3:component">
																	<xsl:value-of select="./v3:monitoringObservation/v3:code/@displayName"/>
																	<xsl:call-template name="printSeperator"/>
																</xsl:for-each>
															</td>
															<td class="formItem">
																<xsl:variable name="sectionNumberSequence">
																	<xsl:apply-templates mode="sectionNumber" select="$indicationSection/ancestor-or-self::v3:section"/>
																</xsl:variable>
																<a href="#section-{substring($sectionNumberSequence,2)}">
																	<xsl:value-of select="$indicationSection/v3:title"/>
																</a>
															</td>
														</tr>
													</xsl:for-each>
													<!-- end repeat -->
													<tr>
														<td>&#160;</td>
													</tr>
													<tr class="formTable">
														<td class="formTitle" colSpan="4">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'limitationsOfUse'"/>
										</xsl:call-template>
														</td>
													</tr>
													<tr class="formTable">
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'useCategory'"/>
										</xsl:call-template>
														</td>
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'preconditionCategory'"/>
										</xsl:call-template>
														</td>
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'precondition'"/>
										</xsl:call-template>
														</td>
														<td class="formTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'labelingSection'"/>
										</xsl:call-template>
														</td>
													</tr>
													<!-- Repeat Each Limitation of Use -->
													<!-- apply all limitation of use templates for issues within this subject -->
													<!-- now apply all limitation of use templates for issues that are NOT within any indication section or subsection -->
													<!-- PCR 593 Since the limitation of use can have multiple ancestors called section, we process all children limitations of the current context.
																 and then all other limitations with specified named ancestors. All possible ancestors other than indication section are used in the predicate.
																 Also made a call to a named template in a loop rather than a matched template-->
													<xsl:for-each select="./v3:substanceAdministration/v3:subjectOf/v3:issue">
														<xsl:call-template name="displayLimitationsOfUse"> </xsl:call-template>
													</xsl:for-each>
													<xsl:for-each select="//v3:excerpt/v3:highlight/v3:subject/v3:substanceAdministration/v3:subjectOf/v3:issue[v3:subject/v3:observationCriterion]">
														<xsl:if test="count(ancestor::v3:section[v3:code/@code=$indicationSectionCode]) = 0">
															<xsl:call-template name="displayLimitationsOfUse"> </xsl:call-template>
														</xsl:if>
													</xsl:for-each>
													<!-- end repeat -->
												</tbody>
											</table>
										</td>
									</tr>
								</xsl:for-each>
								<!--/xsl:for-each-->
								<!-- end repeat -->
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:if>
</xsl:template>
<xsl:template name="PharmacologicalClass">
	<xsl:if test="//v3:generalizedMaterialKind[v3:code/@codeSystem='2.16.840.1.113883.3.26.1.5']">
		<table cellSpacing="0" cellPadding="3" width="100%" class="formTablePetite">
			<tbody>
				<tr>
					<td class="formHeadingTitle">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'pharmacologicClass'"/>
										</xsl:call-template>
					</td>
				</tr>
				<tr class="formTableRowAlt">
					<td class="formItem">
						<table class="formTablePetite" cellSpacing="0" cellPadding="3" width="100%">
							<tbody>
								<tr>
									<td class="formHeadingTitle" width="30%">
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'substance'"/>
										</xsl:call-template>
									</td>
									<td class="formHeadingTitle" width="70%">P
										<xsl:call-template name="hpfb-title">
											<xsl:with-param name="code" select="'pharmacologicClass'"/>
										</xsl:call-template>
									</td>
								</tr>
								<xsl:for-each select="//*[v3:asSpecializedKind]">
									<tr>
										<xsl:attribute name="class">
											<xsl:choose>
												<xsl:when test="position() mod 2 = 0">formTableRow</xsl:when>
												<xsl:otherwise>formTableRowAlt</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<td class="formItem">
											<strong>
												<xsl:value-of select="v3:name"/>
											</strong>
										</td>
										<td class="formItem">
											<xsl:for-each select="v3:asSpecializedKind">
												<xsl:value-of select="v3:generalizedMaterialKind/v3:code/@displayName"/>
												<xsl:if test="contains(v3:generalizedMaterialKind/v3:code/@displayName,'[EPC]')">
													<xsl:value-of select="concat('(', v3:generalizedMaterialKind/v3:name[@use='L'], ')')"/>
												</xsl:if>
												<xsl:call-template name="printSeperator"/>
											</xsl:for-each>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:if>
</xsl:template>

	<xsl:template name="effectiveDate">
		<div class="EffectiveDate">
			<!-- changed by Brian Suggs 11-13-05. Added the Effective Date: text back in so that people will know what this date is for. -->
			<!-- changed by Brian Suggs 08-18-06. Modified text to state "Revised:" as per PCR 528 -->
			<!-- GS: adding support for availabilityTime here -->
			<xsl:variable name="revisionTimeCandidates" select="v3:effectiveTime|v3:availabilityTime"/>
			<xsl:variable name="revisionTime" select="$revisionTimeCandidates/@value"/>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'revisionTimeCandidates'"/>
				</xsl:call-template>:
			<xsl:call-template name="string-to-date">
				<xsl:with-param name="text">
					<xsl:value-of select="$revisionTimeCandidates"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:text>&#160;&#160;&#160;&#160;</xsl:text>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'revisionTime'"/>
				</xsl:call-template>:
			<xsl:call-template name="string-to-date">
				<xsl:with-param name="text">
					<xsl:value-of select="$revisionTime"/>
				</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>

	<xsl:template name="distributorName">
		<div class="DistributorName">
			<xsl:if test="v3:author/v3:assignedEntity/v3:representedOrganization/v3:name != ''">
				<xsl:value-of select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:name"/>
			</xsl:if>
		</div>
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
					<xsl:with-param name="code" select="'conditionOfUse'"/>
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
					<xsl:with-param name="code" select="'conditionOfUse'"/>
				</xsl:call-template>
				</td>
				<td class="formItem">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'adjunct'"/>
				</xsl:call-template>
				</td>
				<td class="formItem">
					<xsl:value-of select="./v3:substanceAdministrationCriterion/v3:consumable/v3:administrableMaterial/v3:administrableMaterialKind/v3:code/@displayName"/>
				</td>
			</xsl:when>
		</xsl:choose>
		<td class="formItem">
			<!--PCR 593 Instead of using the variable $indicationSection the section number is being uniquely determined. for conditionsl of use.
				-->
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
		<xsl:param name="lastDelimiter"><xsl:if test="last() > 2">,</xsl:if>
				&#160;<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'and'"/>
				</xsl:call-template>&#160;
		</xsl:param>
		<xsl:choose>
			<xsl:when test="position() = last() - 1"><xsl:value-of select="$lastDelimiter"/></xsl:when>
			<xsl:when test="position() &lt; last() - 1">, </xsl:when>
		</xsl:choose>
	</xsl:template>
<!-- PCR593 Using a named template instead of a matched template for  v3:issue[v3:subject/v3:observationCriterion] See where it is
			 being called from, for more details.-->
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
					<xsl:with-param name="lastDelimiter">, </xsl:with-param>
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

	<xsl:template name="additionalStyleAttr">
		<xsl:if test="self::*[self::v3:paragraph]//v3:content[@styleCode[contains(.,'xmChange')]] or v3:content[@styleCode[contains(.,'xmChange')]] and not(ancestor::v3:table)">
			<xsl:attribute name="style">
				<xsl:choose>
					<xsl:when test="ancestor::v3:section[v3:code[@code = '34066-1']]">margin-left:-2em; padding-left:2em; border-left:1px solid; position:relative; zoom: 1;</xsl:when>
					<xsl:when test="self::*//v3:content/@styleCode[contains(.,'xmChange')] or v3:content/@styleCode[contains(.,'xmChange')]">border-left:1px solid;</xsl:when>
					<xsl:otherwise>margin-left:-1em; padding-left:1em; border-left:1px solid;</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:if>
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
					<xsl:message>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'warningMissingRequired'"/>
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
	<!-- changed by Brian Suggs 11-16-05.  Added the [name(..) != 'text']  -->
	<!-- PCR 601 Not displaying foonote mark inside a  table of content -->
	<xsl:template name="flushSectionTitleFootnotes">
		<xsl:variable name="footnotes" select="./v3:title/v3:footnote[not(ancestor::v3:table)]"/>
		<xsl:if test="$footnotes">
			<hr class="Footnoterule"/>
			<dl class="Footnote">
				<xsl:apply-templates mode="footnote" select="$footnotes"/>
			</dl>
		</xsl:if>
	</xsl:template>

	<xsl:template name="splitTokens">
		<xsl:param name="text" select="."/>
		<xsl:param name="firstCode" select="substring-before($text,' ')"/>
		<xsl:param name="restOfCodes" select="substring-after($text,' ')"/>
		<xsl:choose>
			<xsl:when test="$firstCode">
				<token value="{concat(translate(substring($firstCode,1,1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($firstCode,2))}"/>
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
	<xsl:template name="uniqueStyleCodes">
		<xsl:param name="in" select="/.."/>
		<xsl:for-each select="$in/token[not(preceding::token/@value = @value)]">
			<xsl:value-of select="@value"/><xsl:text> </xsl:text>
		</xsl:for-each>
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
	<!-- block at sections unless handled specially -->
	<xsl:template mode="data" match="v3:section"/>
	<xsl:template mode="data" match="*[v3:numerator]">
		<xsl:apply-templates mode="data" select="v3:numerator"/>
		<xsl:if test="v3:denominator[not(@value='1' and (not(@unit) or @unit='1'))]">
			<xsl:text> : </xsl:text>
			<xsl:apply-templates mode="data" select="v3:denominator"/>
		</xsl:if>
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
	<xsl:template mode="subjects" match="v3:section[v3:code/@code ='48780-1'][not(v3:subject/v3:manufacturedProduct)]/v3:text">
		<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%">
			<tbody>
				<xsl:call-template name="ProductInfoBasic"/>
			</tbody>
		</table>
	</xsl:template>
	<!-- Note: This template is also used for top level Product Concept which does not have v3:asEquivalentEntity -->
	<xsl:template mode="subjects" match="v3:section/v3:subject/v3:manufacturedProduct/*[self::v3:manufacturedProduct[v3:name or v3:formCode] or self::v3:manufacturedMedicine]|v3:section/v3:subject/v3:identifiedSubstance/v3:identifiedSubstance">
			<table class="contentTablePetite" cellSpacing="0" cellPadding="3" width="100%">
				<tbody>
						<tr>
							<th align="left" class="formHeadingTitle">
								<strong>
								<xsl:choose>
									<xsl:when test="v3:ingredient">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'abstractProductConcept'"/>
				</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'applicationProductConcept'"/>
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
					<!-- FIXME: there seem to be so many different places where the instanceOfKind, that looks somuch like copy&paste and makes maintenance difficult -->
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
	</xsl:template>
<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization">
	<xsl:if test="./v3:name">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite">
					<!-- replace with the label for the role -->
					<!-- 
					value="(document(concat($oid_loc,$file-prefix,$organization-role-oid,$file-suffix)))/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code']/SimpleValue"/>
					<sch:let name="code-oid-display-name" value="((document(concat($oid_loc,$file-prefix,$din-oid,$file-suffix)))/gc:CodeList/SimpleCodeList/Row[./Value[@ColumnRef='code']/SimpleValue=$code-code]/Value[@ColumnRef=$display_language]/SimpleValue)"/>  
            
					 -->
					<xsl:variable name="role_id" select="./v3:id[@root=$organization-role-oid]/@extension"/>
					<xsl:variable name="role_name" select="(document(concat($oid_loc,$file-prefix,$organization-role-oid,$file-suffix)))/gc:CodeList/SimpleCodeList/Row[./Value[@ColumnRef='code']/SimpleValue=$role_id]/Value[@ColumnRef=$display_language]/SimpleValue"/>
			<tr>
				<td colspan="5" class="formHeadingReg">
					<span class="formHeadingTitle" >
						<xsl:variable name="extension" select="current()/id[@root='']/@extension"/>
						<xsl:choose>
							<!-- replace with HPFB codes -->
							<xsl:when test="string($role_name) != 'NaN'">
								<xsl:value-of select="$role_name"/>
							</xsl:when>
							<xsl:otherwise>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'otherParty'"/>
				</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
			<tr>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'role'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'name'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'address'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'ID_FEI'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'businessOperations'"/>
				</xsl:call-template>
				</th>
			</tr>
			<tr class="formTableRowAlt">
				<td class="formItem">
					<xsl:value-of select="$role_name"/>
				</td>
				<td class="formItem">
					<xsl:value-of select="./v3:name"/>
				</td>
				<td class="formItem">
					<xsl:apply-templates mode="format" select="./v3:addr"/>
				</td>
				<!-- root = "1.3.6.1.4.1.519.1" -->
				<!-- TODO -->
				<td class="formItem">
					<xsl:value-of select="./v3:id[@root='1.3.6.1.4.1.519.1']/@extension"/><xsl:if test="./v3:id[@root='1.3.6.1.4.1.519.1']/@extension and ./v3:id[not(@root='1.3.6.1.4.1.519.1')]/@extension">/</xsl:if><xsl:value-of select="./v3:id[not(@root='1.3.6.1.4.1.519.1')]/@extension"/>
				</td>
				<td class="formItem">
					<xsl:for-each select="../v3:performance[not(v3:actDefinition/v3:code/@code = preceding-sibling::*/v3:actDefinition/v3:code/@code)]/v3:actDefinition/v3:code">
						<xsl:variable name="code" select="@code"/>
						<xsl:value-of select="@displayName"/>
						<!-- TODO -->
						<xsl:if test="/v3:document[v3:code/@code = '75030-7'] and ../v3:subjectOf/v3:approval">
							<xsl:text> - </xsl:text>
						</xsl:if>
						<xsl:variable name="itemCodes" select="../../../v3:performance/v3:actDefinition[v3:code/@code = $code]/v3:product/v3:manufacturedProduct/v3:manufacturedMaterialKind/v3:code/@code"/>
						<xsl:if test="$itemCodes">
							<xsl:text>(</xsl:text>
							<xsl:for-each select="$itemCodes">
								<xsl:value-of select="."/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
							<xsl:text>) </xsl:text>
						</xsl:if>
						<xsl:for-each select="../v3:subjectOf/v3:approval/v3:code[@code]">
							<xsl:text>(</xsl:text>
							<xsl:value-of select="@displayName"/>
							<xsl:text>)</xsl:text>
							<!-- TODO -->
							<xsl:if test="/v3:document/v3:code/@code='75030-7' and ../v3:id[@extension]">
								<xsl:text>, </xsl:text>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'licenseInfo'"/>
				</xsl:call-template>&#160;
								<xsl:text>(</xsl:text>
								<xsl:value-of select="concat('Number: ', ../v3:id/@extension, ', ')"/>
								<xsl:value-of select="concat('State: ', ../descendant::v3:territory/v3:code/@code, ', ')"/>
								<xsl:value-of select="concat('Status: ', ../v3:statusCode/@code)"/>
								<xsl:text>) </xsl:text>
							</xsl:if>
							<xsl:for-each select="../v3:subjectOf/v3:action/v3:code[@code]">
								<xsl:if test="position()!=last()">, </xsl:if>
								<xsl:value-of select="@displayName" />
								<xsl:text>(</xsl:text>
								<xsl:if test="../v3:code[@displayName = 'other']">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'text'"/>
				</xsl:call-template>-
									<xsl:value-of select="../v3:text/text()"/>
									<xsl:if test="../v3:subjectOf/v3:document">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:if>
								<xsl:for-each select="../v3:subjectOf/v3:document/v3:text[@mediaType]/v3:reference">
									<xsl:value-of select="@value" />
									<xsl:if test="position()!=last()">, </xsl:if>
								</xsl:for-each>
								<xsl:text>)</xsl:text>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:for-each>
						<xsl:if test="position()!=last()">, </xsl:if>
					</xsl:for-each>
				</td>
			</tr>
			<xsl:call-template name="data-contactParty"/>
			<xsl:for-each select="./v3:assignedEntity[v3:performance/v3:actDefinition/v3:code/@code='C73330']/v3:assignedOrganization">
				<xsl:if test="position() = 1">
					<tr>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'US_AgentID'"/>
				</xsl:call-template>
						</th>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'address'"/>
				</xsl:call-template>
						</th>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'telephoneNumber'"/>
				</xsl:call-template>
						</th>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'emailAddress'"/>
				</xsl:call-template>
						</th>
					</tr>
				</xsl:if>
				<tr class="formTableRowAlt">
					<td class="formItem">
						<xsl:value-of select="v3:name"/>
						<xsl:for-each select="v3:id/@extension">
							<xsl:text> (</xsl:text>
							<xsl:value-of select="."/>
							<xsl:text>)</xsl:text>
						</xsl:for-each>
					</td>
					<td class="formItem">
						<xsl:apply-templates mode="format" select="v3:addr"/>
					</td>
					<td class="formItem">
						<xsl:value-of select=" substring-after(v3:telecom/@value[starts-with(.,'tel:')][1], 'tel:')"/>
						<xsl:for-each select="v3:telecom/@value[starts-with(.,'fax:')]">
							<br/>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'fax'"/>
				</xsl:call-template>:&#160;
							<xsl:value-of select="substring-after(., 'fax:')"/>
						</xsl:for-each>
					</td>
					<td class="formItem">
						<xsl:value-of select=" substring-after(v3:telecom/@value[starts-with(.,'mailto:')][1], 'mailto:')"/>
					</td>
				</tr>
			</xsl:for-each>
			<!-- 53617 changed to 73599 -->
			<xsl:for-each select="./v3:assignedEntity[v3:performance/v3:actDefinition/v3:code/@code='C73599']/v3:assignedOrganization">
				<xsl:if test="position() = 1">
					<tr>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'importerID'"/>
				</xsl:call-template>
						</th>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'address'"/>
				</xsl:call-template>
						</th>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'telephoneNumber'"/>
				</xsl:call-template>
						</th>
						<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'emailAddress'"/>
				</xsl:call-template>
						</th>
					</tr>
				</xsl:if>
				<tr class="formTableRowAlt">
					<td class="formItem">
						<xsl:value-of select="v3:name"/>
						<xsl:for-each select="v3:id/@extension">
							<xsl:text> (</xsl:text>
							<xsl:value-of select="."/>
							<xsl:text>)</xsl:text>
						</xsl:for-each>
					</td>
					<td class="formItem">
						<xsl:apply-templates mode="format" select="v3:addr"/>
					</td>
					<td class="formItem">
						<xsl:value-of select=" substring-after(v3:telecom/@value[starts-with(.,'tel:')][1], 'tel:')"/>
						<xsl:for-each select="v3:telecom/@value[starts-with(.,'fax:')]">
							<br/>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'fax'"/>
				</xsl:call-template>:&#160;
							<xsl:value-of select="substring-after(., 'fax:')"/>
						</xsl:for-each>
					</td>
					<td class="formItem">
						<xsl:value-of select=" substring-after(v3:telecom/@value[starts-with(.,'mailto:')][1], 'mailto:')"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:if>
</xsl:template>
<xsl:template name="data-contactParty">
	<xsl:for-each select="v3:contactParty">
		<xsl:if test="position() = 1">
			<tr>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'contact'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'address'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'telephoneNumber'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'emailAddress'"/>
				</xsl:call-template>
				</th>
			</tr>
		</xsl:if>
		<tr class="formTableRowAlt">
			<td class="formItem">
				<xsl:value-of select="v3:contactPerson/v3:name"/>
			</td>
			<td class="formItem">
				<xsl:apply-templates mode="format" select="v3:addr"/>
			</td>
			<td class="formItem">
				<xsl:value-of select="substring-after(v3:telecom/@value[starts-with(.,'tel:')][1], 'tel:')"/>
				<xsl:for-each select="v3:telecom/@value[starts-with(.,'fax:')]">
					<br/>
					<xsl:text>FAX: </xsl:text>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'role'"/>
				</xsl:call-template>
					<xsl:value-of select="substring-after(., 'fax:')"/>
				</xsl:for-each>
			</td>
			<td class="formItem">
				<xsl:value-of select=" substring-after(v3:telecom/@value[starts-with(.,'mailto:')][1], 'mailto:')"/>
			</td>
		</tr>
	</xsl:for-each>
</xsl:template>
<!-- DIN info -->
<xsl:template mode="subjects" match="//v3:author/v3:assignedEntity/v3:representedOrganization">
	<xsl:if test="(count(./v3:name)>0)">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite">
			<tr>
				<td colspan="4" class="formHeadingReg"><span class="formHeadingTitle" >
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'DIN_Owner'"/>
				</xsl:call-template>&#160;-&#160;
				</span><xsl:value-of select="./v3:name"/>
				<!-- TODO -->
					<xsl:choose>
						<xsl:when test="./v3:id[@root='1.3.6.1.4.1.519.1']/@extension">
							(<xsl:value-of select="./v3:id[@root='1.3.6.1.4.1.519.1']/@extension"/>)
						</xsl:when>
						<xsl:when  test="./v3:assignedEntity/v3:assignedOrganization/v3:id[@root='1.3.6.1.4.1.519.1']/@extension">
							(<xsl:value-of select="./v3:assignedEntity/v3:assignedOrganization/v3:id[@root='1.3.6.1.4.1.519.1']/@extension"/>)
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
				<!-- TODO -->
					<xsl:if test="/v3:document/v3:code/@code[. = '51726-8' or . = '72871-7']">
						<span class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'NDC_LabelerCode'"/>
				</xsl:call-template>:&#160;
						</span>
				<!-- TODO -->
						<xsl:choose>
							<xsl:when test="./v3:id[@root='2.16.840.1.113883.6.69']/@extension">
								<xsl:value-of select="./v3:id[@root='2.16.840.1.113883.6.69']/@extension"/>
							</xsl:when>
							<xsl:when  test="./v3:assignedEntity/v3:assignedOrganization/v3:id[@root='2.16.840.1.113883.6.69']/@extension">
								<xsl:value-of select="./v3:assignedEntity/v3:assignedOrganization/v3:id[@root='2.16.840.1.113883.6.69']/@extension"/>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
					</xsl:if>
				<!-- TODO -->
					<xsl:if test="/v3:document/v3:code/@code[. = '66105-8']">
						<span class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'manufacturerLicenseNumber'"/>
				</xsl:call-template>:&#160;
						</span>
						<xsl:choose>
							<xsl:when test="./v3:id[not(@root='1.3.6.1.4.1.519.1')]/@extension">
								<xsl:value-of select="./v3:id[not(@root='1.3.6.1.4.1.519.1')]/@extension"/>
							</xsl:when>
							<xsl:when  test="./v3:assignedEntity/v3:assignedOrganization/v3:id[not(@root='1.3.6.1.4.1.519.1')]/@extension">
								<xsl:value-of select="./v3:assignedEntity/v3:assignedOrganization/v3:id[not(@root='1.3.6.1.4.1.519.1')]/@extension"/>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
					</xsl:if>
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
					<span class="formHeadingTitle" >
					<!-- TODO -->
						<xsl:choose>
							<xsl:when test="/v3:document/v3:code/@code[. = '75030-7']"> 
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'reporter'"/>
				</xsl:call-template>&#160;-&#160;
							</xsl:when>
							<xsl:otherwise>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'registrant'"/>
				</xsl:call-template>&#160;-&#160;
							</xsl:otherwise>
						</xsl:choose>
					</span><xsl:value-of select="./v3:name"/><xsl:if test="./v3:id/@extension"> (<xsl:value-of select="./v3:id/@extension"/>)</xsl:if>
				</td>
			</tr>
			<xsl:call-template name="data-contactParty"/>
		</table>
	</xsl:if>
</xsl:template>
	<xsl:template mode="format" match="*/v3:addr">
		<table>
			<tr><td>Address:</td><td><xsl:value-of select="./v3:streetAddressLine"/></td></tr>
			<tr><td>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'cityStateZip'"/>
				</xsl:call-template>:
			</td>
				<td>
					<xsl:value-of select="./v3:city"/>
					<xsl:if test="string-length(./v3:state)>0">,&#160;<xsl:value-of select="./v3:state"/></xsl:if>
					<xsl:if test="string-length(./v3:postalCode)>0">,&#160;<xsl:value-of select="./v3:postalCode"/></xsl:if>
				</td>
			</tr>
			<tr><td>Country:</td><td><xsl:value-of select="./v3:country"/></td></tr>
		</table>
	</xsl:template>

	<!-- This section will display all of the subject information in one easy to read table. This view is replacing the previous display of the data elements. -->
	<xsl:template mode="subjects" match="/|@*|node()">
		<xsl:apply-templates mode="subjects" select="@*|node()"/>
	</xsl:template>

	<xsl:template name="equivalentProductInfo">
		<tr>
			<td>
				<table style="font-size:100%"  width="100%"  cellpadding="3" cellspacing="0" class="contentTablePetite">
					<tbody>
						<tr>
							<th align="left" class="formHeadingTitle">
								<strong>
								<xsl:choose>
									<xsl:when test="v3:ingredient">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'abstractProductConcept'"/>
				</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'applicationProductConcept'"/>
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

		<tr>
			<td class="contentTableTitle">
				<strong>
					<xsl:value-of select="$medName"/>&#160;
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
	<xsl:template name="ProductInfoBasic">
		<tr>
			<td>
				<table width="100%" cellpadding="5" cellspacing="0" class="formTablePetite">
					<tr>
						<td colspan="4" class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'productInformation'"/>
				</xsl:call-template>
						</td>
					</tr>
					<tr class="formTableRowAlt">
						<xsl:if test="not(../../v3:part)">
							<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'productType'"/>
				</xsl:call-template>
							</td>
							<td class="formItem">
								<!-- XXX: can't do in XSLT 1.0: xsl:value-of select="replace($documentTypes/v3:document[@code = $root/v3:document/v3:code/@code]/v3:title,'(^| )label( |$)',' ','i')"/ -->
								<xsl:value-of select="$documentTypes/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$root/v3:document/v3:code/@code]/../Value[@ColumnRef=$display_language]/SimpleValue"/>
							</td>
						</xsl:if>
						<xsl:for-each select="v3:code/@code">
							<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'itemCodeSource'"/>
				</xsl:call-template>
							</td>
							<td class="formItem">
								<xsl:variable name="approval" select="current()/../../../v3:subjectOf/v3:approval/v3:code[@codeSystem = $marketing-category-oid]"/>
								<xsl:value-of select="$approval/@displayName" />
								<xsl:text>( </xsl:text>
								<xsl:value-of select="$approval/@code" />
								<xsl:text> )</xsl:text>
							</td>
						</xsl:for-each>
					</tr>
					<xsl:if test="../v3:subjectOf/v3:policy/v3:code/@displayName or  ../v3:consumedIn/*[self::v3:substanceAdministration
					 or self::v3:substanceAdministration1]/v3:routeCode and not(v3:part)">
						<tr class="formTableRow">
							<xsl:if test="../v3:consumedIn/*[self::v3:substanceAdministration or self::v3:substanceAdministration1]/v3:routeCode and not(v3:part)">
								<td width="30%" class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'routeOfAdministration'"/>
				</xsl:call-template>
								</td>
								<td class="formItem">
									<xsl:for-each select="../v3:consumedIn/*[self::v3:substanceAdministration or self::v3:substanceAdministration1]/v3:routeCode">
										<xsl:if test="position() > 1">, </xsl:if>
										<xsl:value-of select="@displayName"/>
									</xsl:for-each>
								</td>
							</xsl:if>
							<xsl:if test="../v3:subjectOf/v3:policy/v3:code/@displayName">
								<td width="30%" class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'DEA_Schedule'"/>
				</xsl:call-template>
								</td>
								<td class="formItem">
									<xsl:value-of select="../v3:subjectOf/v3:policy/v3:code/@displayName"/>&#160;&#160;&#160;&#160;
								</td>
							</xsl:if>
						</tr>
					</xsl:if>
					<xsl:if test="../../../v3:effectiveTime[v3:low/@value or v3:high/@value]  or  ../v3:effectiveTime[v3:low/@value and v3:high/@value]">
						<tr class="formTableRowAlt">
							<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'reportingPeriod'"/>
				</xsl:call-template>
							</td>
							<td class="formItem">
								<xsl:variable name="range" select="ancestor::v3:section[1]/v3:effectiveTime"/>
								<xsl:value-of select="$range/v3:low/@value"/>
								<xsl:text>-</xsl:text>
								<xsl:value-of select="$range/v3:high/@value"/>
							</td>
							<xsl:if test=" ../../../../v3:section[v3:subject/v3:manufacturedProduct]">
								<td class="formLabel"/>
								<td class="formItem"/>
							</xsl:if>
						</tr>
					</xsl:if>
				</table>
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
	<!-- display the imprint information in the specified order.  a apply-template could be used here but then we would not be able to control what order the
			 imprint information is displayed in since there isn't a requirement specifying that the characteristic must be programmed in a certain order-->
	<xsl:template name="characteristics-old">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="4" class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'productCharacteristics'"/>
				</xsl:call-template>
				</td>
			</tr>
			<tr class="formTableRowAlt">
				<xsl:call-template name="color">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='1']"/>
				</xsl:call-template>
				<xsl:call-template name="score">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='5']"/>
				</xsl:call-template>
			</tr>
			<tr class="formTableRowAlt">
				<xsl:call-template name="image">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='2']"/>
				</xsl:call-template>
				<xsl:call-template name="production_amount">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='6']"/>
				</xsl:call-template>
			</tr>
			<tr class="formTableRow">
				<xsl:call-template name="shape">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='3']"/>
				</xsl:call-template>
				<xsl:call-template name="size">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='11']"/>
				</xsl:call-template>
			</tr>
			<tr class="formTableRowAlt">
				<xsl:call-template name="flavor">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='4']"/>
				</xsl:call-template>
				<xsl:call-template name="imprint">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='12']"/>
				</xsl:call-template>
			</tr>
			<tr class="formTableRowAlt">
				<xsl:call-template name="pharmaceutical_standard">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='13']"/>
				</xsl:call-template>
				<xsl:call-template name="scheduling_symbol">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='14']"/>
				</xsl:call-template>
			</tr>
			<tr class="formTableRowAlt">
				<xsl:call-template name="therapeutic_class">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='15']"/>
				</xsl:call-template>
			</tr>
			<tr class="formTableRow">
				<xsl:call-template name="contains">
					<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='SPLCONTAINS']"/>
				</xsl:call-template>
			</tr>
			<xsl:if test="../v3:subjectOf/v3:characteristic[v3:code/@code='SPLCOATING']|../v3:subjectOf/v3:characteristic[v3:code/@code='SPLSYMBOL']">
				<tr class="formTableRowAlt">
					<xsl:call-template name="coating">
						<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='SPLCOATING']"/>
					</xsl:call-template>
					<xsl:call-template name="symbol">
						<xsl:with-param name="path" select="../v3:subjectOf/v3:characteristic[v3:code/@code='SPLSYMBOL']"/>
					</xsl:call-template>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	<xsl:template name="characteristics-new">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="4" class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'productCharacteristics'"/>
				</xsl:call-template>
				</td>
			</tr>
			<xsl:apply-templates mode="characteristics" select="../v3:subjectOf/v3:characteristic">
			<!--
				<xsl:sort select="count($characteristics/*/*/v3:characteristic[v3:code[@code = current()/v3:code/@code and @codeSystem = current()/v3:code/@codeSystem]][1]/preceding::*)"/>
-->
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
	</xsl:template>
<xsl:template name="image">
	<xsl:param name="path" select="."/>
	<xsl:if test="string-length($path/v3:value/v3:reference/@value) > 0">
		<img alt="Image of Product" style="width:20%;" src="{$path/v3:value/v3:reference/@value}"/>
	</xsl:if>
</xsl:template>
<!-- display the characteristic color -->
<xsl:template name="color">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'color'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:for-each select="$path/v3:value">
			<xsl:if test="position() > 1">,&#160;</xsl:if>
			<xsl:value-of select="./@displayName"/>
			<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>) </xsl:if>
		</xsl:for-each>
		<xsl:if test="not($path/v3:value)">&#160;&#160;&#160;&#160;</xsl:if>
	</td>
</xsl:template>
	<!-- display the characteristic production amount -->
	<xsl:template name="production_amount">
		<xsl:param name="path" select="."/>
		<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'productionAmount'"/>
				</xsl:call-template>
		</td>
		<td class="formItem">
			<xsl:for-each select="$path/v3:value">
				<xsl:if test="position() > 1">,&#160;</xsl:if>
				<xsl:value-of select="./@displayName"/>
				<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>) </xsl:if>
			</xsl:for-each>
			<xsl:if test="not($path/v3:value)">&#160;&#160;&#160;&#160;</xsl:if>
		</td>
	</xsl:template>
<!-- display the characteristic score -->
<xsl:template name="score">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'score'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:choose>
			<xsl:when test="$path/v3:value/@nullFlavor='OTH'">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'scoreWithUnevenPieces'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="not($path/v3:value)">&#160;&#160;&#160;&#160;</xsl:when>
			<xsl:when test="$path/v3:value/@value = '1'">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'noScore'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$path/v3:value/@value"/>&#160;
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'pieces'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</td>
</xsl:template>
<!-- display the characteristic shape -->
<xsl:template name="shape">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'shape'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:value-of select="$path/v3:value/@displayName"/>
		<xsl:if test="normalize-space($path/v3:value/v3:originalText)"> (<xsl:value-of select="$path/v3:value/v3:originalText"/>) </xsl:if>
	</td>
</xsl:template>
<!-- display the characteristic flavor -->
<xsl:template name="flavor">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'flavor'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:for-each select="$path/v3:value">
			<xsl:if test="position() > 1">,&#160;</xsl:if>
			<xsl:value-of select="./@displayName"/>
			<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>) </xsl:if>
		</xsl:for-each>
	</td>
</xsl:template>
	<!-- display the characteristic imprint -->
<xsl:template name="imprint">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'imprint'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:value-of select="$path[v3:value/@xsi:type='ST']"/>
	</td>
</xsl:template>
<!-- display the characteristic size -->
<xsl:template name="size">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'size'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:value-of select="$path/v3:value/@value"/>
		<xsl:value-of select="$path/v3:value/@unit"/>
	</td>
</xsl:template>
<!-- display the characteristic symbol -->
<xsl:template name="symbol">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'symbol'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:value-of select="$path/v3:value/@value"/>
	</td>
</xsl:template>
<!-- display the characteristic coating -->
<xsl:template name="coating">
	<xsl:param name="path" select="."/>
	<td class="formLabel">Coating
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'coating'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:value-of select="$path/v3:value/@value"/>
	</td>
</xsl:template>
	<xsl:template name="pharmaceutical_standard">
		<xsl:param name="path" select="."/>
		<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'pharmaceuticalStandard'"/>
				</xsl:call-template>
		</td>
		<td class="formItem">
			<xsl:for-each select="$path/v3:value">
				<xsl:if test="position() > 1">,&#160;</xsl:if>
				<xsl:value-of select="./@displayName"/>
				<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>) </xsl:if>
			</xsl:for-each>
		</td>
	</xsl:template>
	<xsl:template name="scheduling_symbol">
		<xsl:param name="path" select="."/>
		<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'schedulingSymbol'"/>
				</xsl:call-template>
		</td>
		<td class="formItem">
			<xsl:for-each select="$path/v3:value">
				<xsl:if test="position() > 1">,&#160;</xsl:if>
				<xsl:value-of select="./@displayName"/>
				<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>) </xsl:if>
			</xsl:for-each>
		</td>
	</xsl:template>
	<xsl:template name="therapeutic_class">
		<xsl:param name="path" select="."/>
		<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'therapeuticClass'"/>
				</xsl:call-template>
		</td>
		<td class="formItem">
			<xsl:for-each select="$path/v3:value">
				<xsl:if test="position() > 1">,&#160;</xsl:if>
				<xsl:value-of select="./@displayName"/>
				<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>) </xsl:if>
			</xsl:for-each>
		</td>
	</xsl:template>
<xsl:template name="contains">
	<xsl:param name="path" select="."/>
	<td class="formLabel">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'contains'"/>
				</xsl:call-template>
	</td>
	<td class="formItem">
		<xsl:for-each select="$path/v3:value">
			<xsl:if test="position() > 1">,&#160;</xsl:if>
			<xsl:value-of select="./@displayName"/>
			<xsl:if test="normalize-space(./v3:originalText)"> (<xsl:value-of select="./v3:originalText"/>) </xsl:if>
		</xsl:for-each>
		<xsl:if test="not($path/v3:value)">&#160;&#160;&#160;&#160;</xsl:if>
	</td>
</xsl:template>

<xsl:template name="MarketingInfo">
	<xsl:if test="../v3:subjectOf/v3:approval|../v3:subjectOf/v3:marketingAct">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTableMorePetite">
			<tr>
				<td colspan="4" class="formHeadingReg"><span class="formHeadingTitle" >
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'marketingInformation'"/>
				</xsl:call-template>
				</span></td>
			</tr>
			<tr>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'marketingCategory'"/>
				</xsl:call-template>
				</th>
				<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'applicationNumberMonographCitation'"/>
				</xsl:call-template>
				</th>
					<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'marketingStartDate'"/>
				</xsl:call-template>
					</th>
					<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'marketingEndDate'"/>
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
<xsl:template name="string-to-date">
		<xsl:param name="text"/>
		<xsl:param name="displayMonth">true</xsl:param>
		<xsl:param name="displayDay">true</xsl:param>
		<xsl:param name="displayYear">true</xsl:param>
		<xsl:param name="delimiter">/</xsl:param>
		<xsl:if test="string-length($text) > 7">
			<xsl:variable name="year" select="substring($text,1,4)"/>
			<xsl:variable name="month" select="substring($text,5,2)"/>
			<xsl:variable name="day" select="substring($text,7,2)"/>
			<!-- changed by Brian Suggs 11-13-05.  Changes made to display date in MM/DD/YYYY format instead of DD/MM/YYYY format -->
			<xsl:if test="$displayMonth = 'true'">
				<xsl:value-of select="$month"/>
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
			<xsl:if test="$displayDay = 'true'">
				<xsl:value-of select="$day"/>
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
			<xsl:if test="$displayYear = 'true'">
				<xsl:value-of select="$year"/>
			</xsl:if>
		</xsl:if>
</xsl:template>
<xsl:template name="InactiveIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<!-- see PCR 801, just make the header bigger -->
				<td colspan="2" class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'inactiveIngredients'"/>
				</xsl:call-template>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'ingredientName'"/>
				</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'strength'"/>
				</xsl:call-template>
				</th>
			</tr>
			<xsl:if test="not(v3:ingredient[@classCode='IACT']|v3:inactiveIngredient)">
				<tr>
					<td colspan="2" class="formItem" align="center">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'noInactiveIngredientsFound'"/>
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
								<xsl:value-of select="v3:name"/>
							</strong>
							<xsl:text> (</xsl:text>
							<xsl:for-each select="v3:code/@code">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'UNII'"/>
				</xsl:call-template>:
								<xsl:value-of select="."/>
							</xsl:for-each>
							<xsl:text>) </xsl:text>
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
<!-- display the ingredient information (both active and inactive) -->
<xsl:template name="ActiveIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="3" class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'activeIngredientActiveMoiety'"/>
				</xsl:call-template>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'ingredientName'"/>
				</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'basisOfStrength'"/>
				</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'strength'"/>
				</xsl:call-template>
				</th>
			</tr>
			<xsl:if test="not(v3:ingredient[starts-with(@classCode, 'ACTI')]|v3:activeIngredient)">
				<tr>
					<td colspan="3" class="formItem" align="center">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'noActiveIngredientsFound'"/>
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
								<xsl:value-of select="v3:name"/>
							</strong>
							<xsl:text> (</xsl:text>
							<xsl:for-each select="v3:code/@code">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'UNII'"/>
				</xsl:call-template>:
								<xsl:value-of select="."/>
								<xsl:if test="position()!=last()">  
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'and'"/>
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
					<xsl:with-param name="code" select="'UNII'"/>
				</xsl:call-template>:
									<xsl:value-of select="../v3:code/@code"/>
									<xsl:if test="position()!=last()">, </xsl:if>
								</xsl:for-each>
								<xsl:text>) </xsl:text>
							</xsl:if>
							<xsl:for-each select="../v3:subjectOf/v3:substanceSpecification/v3:code[@codeSystem = '2.16.840.1.113883.6.69' or @codeSystem = '2.16.840.1.113883.3.6277']/@code">
								 ( 
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'sourceNDC'"/>
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
						<xsl:value-of select="v3:quantity/v3:numerator/@value"/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:numerator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:numerator/@unit"/></xsl:if>
						<xsl:if test="(v3:quantity/v3:denominator/@value and normalize-space(v3:quantity/v3:denominator/@value)!='1')
													or (v3:quantity/v3:denominator/@unit and normalize-space(v3:quantity/v3:denominator/@unit)!='1')"> &#160;in&#160;<xsl:value-of select="v3:quantity/v3:denominator/@value"
													/>&#160;<xsl:if test="normalize-space(v3:quantity/v3:denominator/@unit)!='1'"><xsl:value-of select="v3:quantity/v3:denominator/@unit"/>
							</xsl:if></xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
</xsl:template>
<xsl:template name="otherIngredients">
		<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
			<tr>
				<td colspan="3" class="formHeadingTitle">
					<xsl:if test="v3:ingredient[@classCode = 'INGR' or starts-with(@classCode,'ACTI')]">Other </xsl:if>
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'ingredients'"/>
				</xsl:call-template>
				</td>
			</tr>
			<tr>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'ingredientKind'"/>
				</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'ingredientName'"/>
				</xsl:call-template>
				</th>
				<th class="formTitle" scope="col">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'quantity'"/>
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
							<xsl:when test="@classCode = 'BASE'">Base
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'base'"/>
				</xsl:call-template>
							</xsl:when>
							<xsl:when test="@classCode = 'ADTV'">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'additive'"/>
				</xsl:call-template>
							</xsl:when>
							<xsl:when test="@classCode = 'CNTM' and v3:quantity/v3:numerator/@value='0'">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'doesNotContain'"/>
				</xsl:call-template>
							</xsl:when>
							<xsl:when test="@classCode = 'CNTM'">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'mayContain'"/>
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
								<xsl:value-of select="v3:name"/>
							</strong>
							<xsl:text> (</xsl:text>
							<xsl:for-each select="v3:code/@code">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'UNII'"/>
				</xsl:call-template>:
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
<xsl:template name="packaging">
	<xsl:param name="path" select="."/>
	<table width="100%" cellpadding="3" cellspacing="0" class="formTablePetite">
		<tr>
			<td colspan="5" class="formHeadingTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'packaging'"/>
				</xsl:call-template>
			</td>
		</tr>
		<tr>
			<th scope="col" width="1" class="formTitle">#</th>
			<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'itemCode'"/>
				</xsl:call-template>
			</th>
			<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'packageDescription'"/>
				</xsl:call-template>
			</th>
			<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'marketingStartDate'"/>
				</xsl:call-template>
			</th>
			<th scope="col" class="formTitle">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'marketingEndDate'"/>
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
					<xsl:with-param name="code" select="'packageInformationNotApplicable'"/>
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
				<xsl:value-of select="$approval/@displayName"/>
				<xsl:text>:</xsl:text>
				<xsl:value-of select="$approval/@code"/>
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
	</xsl:for-each>
</xsl:template>

<xsl:template match="v3:text[not(parent::v3:observationMedia)]">
<!-- Health Canada Change added font size attribute below-->
	<text style="font-size:1.1em;">
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates mode="mixed" select="node()"/>
		<xsl:apply-templates mode="rems" select="../v3:subject2[v3:substanceAdministration/v3:componentOf/v3:protocol]"/>
		<xsl:call-template name="flushfootnotes">
			<xsl:with-param name="isTableOfContent" select="'no'"/>
		</xsl:call-template>
	</text>
</xsl:template>

<!-- Health Canada Change-->
	<!-- PARAGRAPH MODEL -->
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
<!-- LIST MODEL -->
<xsl:template match="v3:list[@listType='ordered' and not(v3:item/v3:caption)]" priority="1">
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
<xsl:template match="v3:list/v3:item[not(parent::v3:list/v3:item/v3:caption)]">
		<!-- Health Canada added font size attribute -->
		<li style="font-size:1.1em;">
			<xsl:apply-templates select="@*"/>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</li>
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
<xsl:template match="v3:td">
		<!-- determine our position to find out the associated col -->
		<xsl:param name="position">
			<xsl:choose>
				<xsl:when test="string(number(preceding-sibling::v3:td/@colspan[number(.)>0]) != 'NaN')">
					<xsl:value-of select="1 + count(preceding-sibling::v3:td[not(@colspan[number(.) > 0])])
						+sum(preceding-sibling::v3:td/@colspan[number(.)>0])"/>
				</xsl:when>
				<xsl:when test="preceding-sibling::v3:td[not(@colspan[number(.) > 0])]">
					<xsl:value-of select="1 + count(preceding-sibling::v3:td[not(@colspan[number(.) > 0])])"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="1" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="associatedCol" select="(ancestor::v3:table/v3:colgroup/v3:col|ancestor::v3:table/v3:col)[$position]"/>
		<xsl:param name="associatedColgroup" select="$associatedCol/parent::v3:colgroup"/>
		<!-- Health Canada Change added attributes for td-->
		<td style="padding:5px; border: solid 1px;">
			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode">
					<xsl:if test="not(ancestor::v3:tfoot) and ((contains($associatedColgroup/@styleCode,'Lrule') and not($associatedCol/preceding-sibling::v3:col)) or contains($associatedCol/@styleCode, 'Lrule'))">
						<xsl:text> Lrule </xsl:text>
					</xsl:if>
					<xsl:if test="not(ancestor::v3:tfoot) and ((contains($associatedColgroup/@styleCode,'Rrule') and not($associatedCol/following-sibling::v3:col)) or contains($associatedCol/@styleCode, 'Rrule'))">
						<xsl:text> Rrule </xsl:text>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="additionalStyleAttr"/>
			<xsl:copy-of select="$associatedCol/@align"/>
			<xsl:apply-templates select="@*[not(local-name(.)='styleCode')]"/>
			<xsl:apply-templates mode="mixed" select="node()"/>
		</td>
</xsl:template>
<xsl:template match="v3:td/@align|v3:td/@char|v3:td/@charoff|v3:td/@valign|v3:td/@abbr|v3:td/@axis|v3:td/@headers|v3:td/@scope|v3:td/@rowspan|v3:td/@colspan">
		<xsl:copy-of select="."/>
</xsl:template>
<xsl:template mode="highlights" match="/|@*|node()">
		<xsl:apply-templates mode="highlights" select="@*|node()"/>
</xsl:template>
<xsl:template mode="highlights" match="/v3:document">
		<div id="Highlights" class="Highlights">
			<table cellspacing="5" cellpadding="5" width="100%" style="table-layout:fixed">
				<tr>
					<td width="50%" align="left" valign="top"><div/></td>
					<td width="50%" align="left" valign="top">
						<div>
							<h1>
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'hightlightsOfPrescribingInformation'"/>
								</xsl:call-template>
							</h1>
							<xsl:apply-templates mode="highlights" select="@*|node()" />
						</div>
					</td>
				</tr>
			</table>
		</div>
</xsl:template>
<xsl:template mode="highlights" match="/v3:document/v3:title">
		<div class="HighlightsDisclaimer">
			<xsl:apply-templates mode="mixed" select="."/>
		</div>
</xsl:template>
<xsl:template mode="highlights" match="v3:structuredBody">
		<!-- here is where we undertake some hard re-ordering -->
		<xsl:variable name="body" select="."/>
		<xsl:apply-templates mode="highlights" select="$body/*"/>
<!--TODO
		<xsl:call-template name="patientLabelReference"/>
		<xsl:call-template name="flushDocumentTitleFootnotes"/>
-->
		<xsl:call-template name="effectiveDateHighlights"/>
</xsl:template>
<xsl:template mode="highlights" match="v3:section">
		<xsl:param name="suppressTitle" select="/.."/>
		<xsl:param name="doNotSuppressFrontOrBackMatter" select="/.."/>
			<div>
				<xsl:if test="v3:excerpt and not($suppressTitle)">
					<xsl:call-template name="styleCodeAttr">
						<xsl:with-param name="styleCode" select="@styleCode"/>
						<xsl:with-param name="additionalStyleCode">Highlight<xsl:if test="ancestor::v3:section[v3:excerpt]">Sub</xsl:if>Section</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:apply-templates mode="highlights" select="@*|v3:excerpt">
					<xsl:with-param name="suppressTitle" select="$suppressTitle"/>
				</xsl:apply-templates>
				<xsl:apply-templates mode="highlights" select="node()[not(self::v3:excerpt)]">
					<xsl:with-param name="suppressTitle" select="$suppressTitle"/>
				</xsl:apply-templates>
			</div>
</xsl:template>
<xsl:template mode="highlights" match="v3:section[v3:code[@codeSystem='2.16.840.1.113883.6.1' and @code='34066-1']][v3:excerpt]">	<!-- BOXED WARNING -->
		<xsl:param name="doNotSuppressFrontOrBackMatter" select="/.."/>
		<xsl:if test="$doNotSuppressFrontOrBackMatter">
			<div class="Warning">
				<xsl:apply-templates mode="highlights" select="@*|v3:excerpt">
					<xsl:with-param name="suppressTitle" select="1"/>
				</xsl:apply-templates>
				<xsl:apply-templates mode="highlights" select="node()[not(self::v3:excerpt)]">
					<xsl:with-param name="suppressTitle" select="1"/>
				</xsl:apply-templates>
			</div>
		</xsl:if>
</xsl:template>
<xsl:template mode="highlights" match="v3:excerpt">
		<xsl:param name="suppressTitle" select="/.."/>
		<xsl:variable name="currentCode" select="parent::v3:section/v3:code/@code"/>
		<xsl:variable name="currentSectionNum">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<xsl:if test="not($suppressTitle)">
			<h1 class="Highlights">
				<span>
					<xsl:value-of select="translate(v3:code/@displayName,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
				</span>
			</h1>
		</xsl:if>
		<div>
			<xsl:apply-templates mode="mixed" select="@*|node()[not(self::v3:title)]"/>
		</div>
</xsl:template>
<xsl:template name="recent-effectiveDate">
		<xsl:param name="effectiveDateSequence" />
		<xsl:for-each select="$effectiveDateSequence[string-length(.) &gt; 7]">
			<xsl:sort select="." order="descending"/>
			<xsl:if test="position() = 1">
				<v3:effectiveTime value="{.}" />
			</xsl:if>
		</xsl:for-each>
</xsl:template>
<xsl:template name="effectiveDateHighlights">
		<xsl:if test="/v3:document/v3:effectiveTime[@value != '']">
			<xsl:variable name="recent-contentOfLabeling-effectiveDate">
				<xsl:call-template name="recent-effectiveDate">
					<xsl:with-param name="effectiveDateSequence" select="/v3:document/v3:component/v3:structuredBody/v3:component[not(v3:section/v3:code/@code = '48780-1')]/v3:section/v3:effectiveTime/@value"/>
				</xsl:call-template>
			</xsl:variable>
			<p class="HighlightsRevision">
				<xsl:call-template name="hpfb-title">
					<xsl:with-param name="code" select="'revised'"/>
				</xsl:call-template> :
				<xsl:choose>
					<xsl:when test="function-available('exsl:node-set')">
						<xsl:apply-templates mode="data" select="exsl:node-set($recent-contentOfLabeling-effectiveDate)/v3:effectiveTime">
							<xsl:with-param name="displayMonth">true</xsl:with-param>
							<xsl:with-param name="displayDay">false</xsl:with-param>
							<xsl:with-param name="displayYear">true</xsl:with-param>
							<xsl:with-param name="delimiter">/</xsl:with-param>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="function-available('msxsl:node-set')">
						<xsl:apply-templates mode="data" select="msxsl:node-set($recent-contentOfLabeling-effectiveDate)/v3:effectiveTime">
							<xsl:with-param name="displayMonth">true</xsl:with-param>
							<xsl:with-param name="displayDay">false</xsl:with-param>
							<xsl:with-param name="displayYear">true</xsl:with-param>
							<xsl:with-param name="delimiter">/</xsl:with-param>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:message terminate="yes"><xsl:call-template name="hpfb-title"><xsl:with-param name="code" select="'messageTxt'"/></xsl:call-template></xsl:message>
					</xsl:otherwise>
				</xsl:choose>
			</p>
		</xsl:if>
</xsl:template>
<!-- MODE index -->
<xsl:template mode="index" match="/|@*|node()">
		<xsl:apply-templates mode="index" select="@*|node()"/>
</xsl:template>

<xsl:template mode="index" match="v3:document" priority="0">
		<div id="Index" class="Index">
			<table cellspacing="5" cellpadding="5" width="100%" style="table-layout:fixed">
				<tr>
					<td width="50%" align="left" valign="top">
						<div/>
					</td>
					<td width="50%" align="left" valign="top">
						<div>
							<h1 class="Colspan">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'fullPrescribingInformation'"/>
								</xsl:call-template>:&#160;
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'contents'"/>
								</xsl:call-template>
								<a href="#footnote-content" name="footnote-reference-content">*</a>
							</h1>
							<xsl:apply-templates mode="index" select="@*|node()" />
							<dl class="Footnote">
								<dt>
									<a href="#footnote-reference-content" name="footnote-content">*</a>
								</dt>
								<dd>
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'sectionsSubsectionsOmitted'"/>
								</xsl:call-template>
								</dd>
							</dl>
						</div>
					</td>
				</tr>
			</table>
		</div>
</xsl:template>
<xsl:template mode="index" match="v3:section[v3:title and descendant::v3:text[parent::v3:section]]" priority="0">
		<xsl:param name="sectionLevel" select="count(ancestor::v3:section)+1"/>
		<xsl:param name="sectionNumber" select="/.."/>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<xsl:if test="$sectionLevel &lt; 3">
			<xsl:element name="h{$sectionLevel}">
				<a href="#section-{substring($sectionNumberSequence,2)}">
					<xsl:attribute name="class">toc</xsl:attribute>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates mode="mixed" select="./v3:title/node()">
						<xsl:with-param name="isTableOfContent" select="'yes'"/>
					</xsl:apply-templates>
				</a>
			</xsl:element>
			<xsl:apply-templates mode="index" select="@*|node()"/>
		</xsl:if>
</xsl:template>

<xsl:template mode="twoColumn" match="v3:analyte">
		<tr>
			<xsl:if test="position() = 1">
				<td class="formTitle" colspan="2">
								<xsl:call-template name="hpfb-title">
									<xsl:with-param name="code" select="'substanceMeasured'"/>
								</xsl:call-template>
				</td>
			</xsl:if>
		</tr>
		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 1">formTableRow</xsl:when>
					<xsl:otherwise>formTableRowAlt</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="."></xsl:apply-templates>
			<xsl:apply-templates select="following-sibling::v3:analyte[1]"></xsl:apply-templates>
		</tr>
</xsl:template>
<xsl:template mode="twocolumn" match="/|node()|@*">
		<xsl:param name="class"/>
		<xsl:copy>
			<xsl:apply-templates mode="twocolumn" select="@*|node()">
				<xsl:with-param name="class" select="$class"/>
			</xsl:apply-templates>
		</xsl:copy>
</xsl:template>

<xsl:template name="hpfb-label">
		<xsl:param name="codeSystem" select="/.."/>
		<xsl:param name="code" select="/.."/>
		<xsl:variable name="tempDoc" select="document(concat($oid_loc,$file-prefix,$codeSystem,$file-suffix))"/>
		<xsl:variable name="node" select="$tempDoc/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]"/>
		<xsl:value-of select="$node/../Value[@ColumnRef=$display_language]/SimpleValue"/> 
</xsl:template>
<xsl:template name="hpfb-title">
	<xsl:param name="code" select="/.." />
	<xsl:variable name="node" select="$vocabulary/gc:CodeList/SimpleCodeList/Row/Value[@ColumnRef='code' and SimpleValue=$code]"/>
	<xsl:value-of select="$node/../Value[@ColumnRef=$display_language]/SimpleValue"/> 
</xsl:template>
</xsl:transform>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="HPFB" userelativepaths="yes" externalpreview="yes" url="..\test\1.xml" htmlbaseurl="" outputurl="..\test\test2.html" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
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