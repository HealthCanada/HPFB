<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:param name="labelFile" select="'./hp-ip400-labels.xml'"/>
	<xsl:param name="cssFile" select="'./ip400.css'"/>
	<xsl:param name="language" select="'eng'"/>
	<xsl:variable name="labelLookup" select="document($labelFile)"/>
	<xsl:variable name="cssLookup" select="document($cssFile)"/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="X-UA-Compatible" content="IE=9"/>
				<style type="text/css">
					<xsl:value-of select="$cssLookup/css"/>
				</style>
			</head>
            <body>
				<xsl:call-template name="mybody" />
<!--				<xsl:if test="count(DOSSIER_ENROL) &gt; 0"> <xsl:apply-templates select="DOSSIER_ENROL"></xsl:apply-templates> </xsl:if>-->
			</body>
		</html>
	</xsl:template>
	<!-- Company Enrolment -->
	<xsl:template name="mybody">
		<h1><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSSIER_ENROL'"/></xsl:call-template></h1>
		<div class="well well-sm" >
			<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
				<TR>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EnrolStatus'"/></xsl:call-template></td>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ENROL_VERSION'"/></xsl:call-template></td>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SAVED'"/></xsl:call-template></td>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierID'"/></xsl:call-template></td>
				</TR>
				<TR>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::general_information/status" /></span></td>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::general_information/enrol_version" /></span></td>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::general_information/last_saved_date" /></span></td>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::general_information/dossier_id" /></span></td>
				</TR>
			</TABLE>
		</div>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierInfo'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h2>
				</div>
				
				<div class="panel-body">
					<div class="row">&#160;
						<div class="col-xs-12">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'A_DossierType'"></xsl:with-param></xsl:call-template>:&#160;</label>
							<span class="nowrap normalWeight mouseHover"><xsl:value-of select="/descendant-or-self::dossier/dossier_type"/></span>
						</div>
					</div>
					<div class="row">&#160;
						<div class="col-xs-3">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURE_CO_ID'"></xsl:with-param></xsl:call-template>:&#160;
							<span class="nowrap normalWeight mouseHover"><xsl:value-of select="/descendant-or-self::dossier/company_id"/></span></label>
						</div>
						<div class="col-xs-3">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURE_CONTACT_ID'"></xsl:with-param></xsl:call-template>:&#160;
							<span class="nowrap normalWeight mouseHover"><xsl:value-of select="/descendant-or-self::dossier/contact_id"/></span></label>
						</div>
						<div class="col-xs-3">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_CLASS'"></xsl:with-param></xsl:call-template>:&#160;
							<span class="nowrap normalWeight mouseHover">
									<xsl:choose>
									<xsl:when test="/descendant-or-self::dossier/device_class = 'DC2'">
										<xsl:text>CLASS II</xsl:text>
									</xsl:when>
									<xsl:when test="/descendant-or-self::dossier/device_class = 'DC3'">
										<xsl:text>CLASS III</xsl:text>
									</xsl:when>
									<xsl:when test="/descendant-or-self::dossier/device_class = 'DC4'">
										<xsl:text>CLASS IV</xsl:text>
									</xsl:when>
									</xsl:choose>
							</span></label>
						</div>
					</div>
					<div class="row">&#160;
						<div class="col-xs-10">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_NAME'"></xsl:with-param></xsl:call-template>:&#160;</label>
							<span class="normalWeight mouseHover"><xsl:value-of select="/descendant-or-self::dossier/device_name"/></span>
						</div>
					</div>
					<div class="row">&#160;
						<div class="col-xs-10">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'QC_MANAGE_SYS_CERTIFICATE'"></xsl:with-param></xsl:call-template>:&#160;</label>
							<span class="nowrap normalWeight mouseHover">
								<xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::dossier/has_qmsc"/></xsl:call-template>
							</span>
						</div>
					</div>
					<div class="row">&#160;
						<div class="col-xs-5">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'QMSC_REGISTRAR'"></xsl:with-param></xsl:call-template>:&#160;
							<span class="normalWeight mouseHover">
							<xsl:value-of select="dossier/registrar"/>
								<xsl:choose><xsl:when test="$language = 'eng'"><xsl:value-of select="/descendant-or-self::dossier/registrar/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="/descendant-or-self::dossier/registrar/@label_fr"/></xsl:otherwise></xsl:choose>
							</span></label>
						</div>
						<div class="col-xs-5">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LICENCE_APP_TYPE'"></xsl:with-param></xsl:call-template>:&#160;
							<span class="normalWeight mouseHover">
								<xsl:choose><xsl:when test="$language = 'eng'"><xsl:value-of select="/descendant-or-self::dossier/licence_application_type/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="/descendant-or-self::dossier/licence_application_type/@label_fr"/></xsl:otherwise></xsl:choose>
							</span></label>
						</div>
					</div>
					<div class="row">&#160;
						<div class="col-xs-10">
							<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADDITIONAL_FLD_CONTXT'"></xsl:with-param></xsl:call-template>:&#160;</strong>
						</div>
						<div class="col-xs-10 container">
							<span class="mouseHover">
							<xsl:value-of select="/descendant-or-self::dossier/additional_field"/>
							</span>
						</div>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
	<xsl:template name="hp-label">
		<xsl:param name="code" select="/.."/>
		<xsl:variable name="value" select="$labelLookup/SimpleCodeList/row[code=$code]/*[name()=$language]"/>
		<xsl:if test="$value">
			<xsl:for-each select="$labelLookup/SimpleCodeList/row[code=$code]/*[name()=$language]"><xsl:if test="position() > 1"><xsl:text disable-output-escaping="yes">&lt;br/&gt;</xsl:text></xsl:if><xsl:value-of select="."/></xsl:for-each>
		</xsl:if>
		<xsl:if test="not($value)">Error: code missing:(<xsl:value-of select="$code"/> in <xsl:value-of select="$labelFile"/>)</xsl:if>
	</xsl:template>
	<xsl:template name="YesNoUnknow">
		<xsl:param name="value" select="/.."/>
		<xsl:choose>
		<xsl:when test="$value = 'Y' or $value = 'yes'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Yes'"/></xsl:call-template>
		</xsl:when>
		<xsl:when test="$value = 'N' or $value = 'no'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'No'"/></xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'UNKNOWN'"/></xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="..\..\..\..\..\Downloads\hcrepdom-A123456-2-0.xml" htmlbaseurl="" outputurl="..\..\..\..\..\..\..\SPM\test\mds_dossier.html" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="cssFile" value="'C:\Users\hcuser\git\HC-IMSD\REP\xslt\ip400.css'"/>
			<parameterValue name="labelFile" value="'C:\Users\hcuser\git\HC-IMSD\REP\xslt\hp-ip400-labels.xml'"/>
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