<?xml version="1.0" encoding="us-ascii"?>
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
Portions created by Initial Developer are Copyright (C) 2002-2004
Health Level Seven, Inc. All Rights Reserved.

Contributor(s): Steven Gitterman, Brian Keller

Revision: $Id: spl.xsl,v 1.52 2005/08/26 05:59:26 gschadow Exp $

Revision: $Id: spl-common.xsl,v 2.0 2006/08/18 04:11:00 sbsuggs Exp $

-->

<!-- HPFB Changes:
	1.	changed the resource locations to the HPFB instances.
	pbx: is para 2 still valid?
	2. Linking to the HPFB css renders the product data table incorrectly, needs to be resolved!
	https://github.com/IanYangCa/HPFB/blob/master/Structured-Product-Labeling-(SPL)/Style-Sheets/SPM/dev/hpfb-spl.js
-->

<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v3="urn:hl7-org:v3" exclude-result-prefixes="v3 xsl">
	<xsl:import href="hpfb-spl-core.xsl"/>
	<!-- Whether to show the clickable XML, set to "/.." instead of "1" to turn off -->
	<xsl:param name="show-subjects-xml" select="0"/>
	<!-- Whether to show the data elements in special tables etc., set to "/.." instead of "1" to turn off -->
	<xsl:param name="show-data" select="1"/>
	<!-- pbx: is the item below still true? -->
	<!-- HPFB: for some reason linking to the HPFB css renders the product data table incorrectly, needs to be resolved -->
	<!-- Whether to show section numbers, set to 1 to enable and "/.." to turn off-->
	<xsl:param name="show-section-numbers" select="/.."/>
	<!-- Whether to process mixins -->
	<xsl:param name="process-mixins" select="true()"/>
	<!-- "/.." means the value come from parent or caller parameter -->
	<xsl:param name="oids-base-url" select="'https://raw.githubusercontent.com/HealthCanada/HPFB/master/Controlled-Vocabularies/Content/'" />

	<!-- This is the CSS link put into the output -->
	<!-- Where to find JavaScript resources -->
	<!-- pbx: this points to prod, should point to dev! -->
	<xsl:param name="resourcesdir" select="'https://rawgit.com/HealthCanada/HPFB/master/Structured-Product-Labeling-(SPL)/Style-Sheets/SPM/current/'" />
	<xsl:param name="css" select="concat($resourcesdir, 'hpfb-spl-core.css')" />
	<!-- is there any reason we render HTML 1.0?  -->
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
</xsl:transform>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="..\..\..\..\..\..\..\..\..\SPM\test\1.xml" htmlbaseurl="" outputurl="..\..\..\..\..\..\..\..\..\SPM\test\test4.html" processortype="saxon8" useresolver="yes"
		          profilemode="7" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="oids-base-url" value="'https://raw.githubusercontent.com/HealthCanada/HPFB/master/Controlled-Vocabularies/Content/'"/>
			<parameterValue name="resourcesdir" value="'https://rawgit.com/IanYangCa/HPFB/master/Structured-Product-Labeling-(SPL)/Style-Sheets/SPM/dev/'"/>
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\test\a6c469cf-5820-48a8-b140-f8f4d63f5700.xml" srcSchemaRoot="document" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->