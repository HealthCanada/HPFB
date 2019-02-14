<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:param name="labelFile" select="'./hp-ip400-labels.xml'"/>
	<xsl:param name="cssFile" select="'./ip400.css'"/>
	<xsl:param name="language" select="'eng'"/>
	<xsl:variable name="labelLookup" select="document($labelFile)"/>
	<xsl:variable name="cssLookup" select="document($cssFile)"/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:variable name="docRoot" select="/" />
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
			</body>
		</html>
	</xsl:template>
	
	<!-- Application Information Enrolment -->

	<xsl:template name="mybody">
		<h1><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TRANSACTION_INFO_TMPL'"/></xsl:call-template></h1>
		<div class="well well-sm" >
			<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
				<TR>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_ID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SAVED'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACT_ID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSSIER_TYPE'"/></xsl:call-template></TD>
				</TR>
				<TR>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/regulatory_company_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover">HC6-024-<xsl:apply-templates select="/descendant-or-self::application_info/dossier_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/last_saved_date" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/regulatory_contact_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/dossier_type" /></span> </TD>
				</TR>
			</TABLE>
		</div>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_TRANS_INFO'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">
					<section class="panel panel-default" >
<!--							<header class="panel-heading" style="color:#030303; background-color:#f8f8f8;">
								<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PLACE_OF_USE'"/></xsl:call-template></h2>
							</header>-->
							<div class="panel-body">
								<div class="row">
									<div class="col-xs-6">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURING_COMPANY_ID'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/manufacturing_company_id"/></span>
									</div>
									<div class="col-xs-6">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURING_CONTACT_ID'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/manufacturing_contact_id"/></span>
									</div>
									<div class="col-xs-6">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACTIVITY_LEAD'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/activity_lead"/></span>
									</div>
									<div class="col-xs-6">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACTIVITY_TYPE'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/activity_type"/></span>
									</div>
									<div class="col-xs-6">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Transaction_Desc'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:call-template name="getLabel"><xsl:with-param name="node" select="/descendant-or-self::application_info/transaction_description"/></xsl:call-template></span>
									</div>
									<xsl:if test="/descendant-or-self::application_info/device_class != ''">
										<div class="col-xs-6">
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Device_Class'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover">
												<xsl:choose>
												<xsl:when test="/descendant-or-self::application_info/device_class = 'DC2'">
													<xsl:text>CLASS II</xsl:text>
												</xsl:when>
												<xsl:when test="/descendant-or-self::application_info/device_class = 'DC3'">
													<xsl:text>CLASS III</xsl:text>
												</xsl:when>
												<xsl:when test="/descendant-or-self::application_info/device_class = 'DC4'">
													<xsl:text>CLASS IV</xsl:text>
												</xsl:when>
												</xsl:choose>
											</span>
										</div>
									</xsl:if>
								</div>
								<xsl:if test="count(/descendant-or-self::application_info/amend_reasons/*[. = 'yes']) > 0">
									<div class="row">&#160;</div>
									<div class="row">
										<div class="col-xs-12"><strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Reason_for_Amendment'"/></xsl:call-template></strong></div>
									</div>
									<div class="row">
										<xsl:for-each select="/descendant-or-self::application_info/amend_reasons/*">
											<xsl:if test=". = 'yes'">
												<div class="col-xs-6">
										            <xsl:element name="input">
					                                    <xsl:attribute name="type">checkbox</xsl:attribute>
				                                        <xsl:attribute name="checked"></xsl:attribute>
					                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
														<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
					                                </xsl:element>
													<span class="mouseHover">
														<xsl:call-template name="hp-label"><xsl:with-param name="code" select="./name()"/></xsl:call-template>
													</span>
												</div>
											</xsl:if>
										</xsl:for-each>
									</div>
								</xsl:if>
								<div class="row">&#160;</div>
								<div class="row">
									<xsl:if test="/descendant-or-self::application_info/licence_number != ''">
										<div class="col-xs-6">
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_LICENCE'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/licence_number"/></span>
										</div>
										<div class="col-xs-10">
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Proposed_Licence_Name'"></xsl:with-param></xsl:call-template>:&#160;<br/></label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/proposed_licence_name"/></span>
										</div>
									</xsl:if>
									<xsl:if test="/descendant-or-self::application_info/application_number != ''">
										<div class="col-xs-6">
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Application_Number'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/application_number"/></span>
										</div>
									</xsl:if>

									<xsl:if test="/descendant-or-self::application_info/device_name != ''">
										<div class="col-xs-6">
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_NAME'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/device_name"/></span>
										</div>
									</xsl:if>
									<xsl:if test="/descendant-or-self::application_info/request_date != ''">
										<div class="col-xs-6">
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MEETING_ID'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/meeting_id"/></span>
										</div>
										<div class="col-xs-6">
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Date_of_Request'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/request_date"/></span>
										</div>
									</xsl:if>
									<div class="col-xs-6">
							            <xsl:element name="input">
		                                    <xsl:attribute name="type">checkbox</xsl:attribute>
		                                    <xsl:if test=" /descendant-or-self::application_info/has_ddt = 'yes'">
		                                        <xsl:attribute name="checked"></xsl:attribute>
		                                    </xsl:if>
		                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
											<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
		                                </xsl:element>
										<span class="mouseHover">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Device_details_table'"/></xsl:call-template></strong>
										</span>
									</div>
									<div class="col-xs-6">
							            <xsl:element name="input">
		                                    <xsl:attribute name="type">checkbox</xsl:attribute>
		                                    <xsl:if test=" /descendant-or-self::application_info/has_app_info = 'yes'">
		                                        <xsl:attribute name="checked"></xsl:attribute>
		                                    </xsl:if>
		                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
											<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
		                                </xsl:element>
										<span class="mouseHover">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'App_Info_XML_Include'"/></xsl:call-template></strong>
										</span>
									</div>
									<div class="col-xs-6">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_SOLICITED'"></xsl:with-param></xsl:call-template>&#160;</label>
										<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/is_solicited_info"/></xsl:call-template></span>
									</div>
								</div>
							</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading"  style="color:#030303; background-color:#f8f8f8;">
							<h3 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Transaction_Req_Info'"/></xsl:call-template></h3>
						</div>
						<div class="panel-body">
							<table class="table dataTable table-bordered table-hover table-condensed table-striped">
								<thead>
									<tr><th>&#160;</th><th><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Transaction_Req_Info'"/></xsl:call-template></th></tr>
								</thead>
								<tbody>
									<xsl:for-each select="/descendant-or-self::requesters/*">
										<tr><td><xsl:value-of select="./id + 1"/></td>
										<td>
											<xsl:call-template name="getLabel"><xsl:with-param name="node" select="./requester"/></xsl:call-template>
										</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
					</section>
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
		<xsl:when test="$value = 'yes'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Yes'"/></xsl:call-template>
		</xsl:when>
		<xsl:when test="$value = 'no'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'No'"/></xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'UNKNOWN'"/></xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="getLabel">
		<xsl:param name="node" select="/.."/>
		<xsl:choose>
		<xsl:when test="$language = 'fra'">
			<xsl:value-of select="$node/@label_fr"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$node/@label_en"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="no" externalpreview="yes" url="file:///e:/ip400Demo/mds/hcreprtm-2019-02-07-0946.xml" htmlbaseurl="" outputurl="file:///c:/SPM/test/TRANSACTION.html" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="cssFile" value="'file:///C:/Users/hcuser/git/HC-IMSD/REP/xslt/ip400.css'"/>
			<parameterValue name="labelFile" value="'file:///C:/Users/hcuser/git/HC-IMSD/REP/xslt/hp-ip400-labels.xml'"/>
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