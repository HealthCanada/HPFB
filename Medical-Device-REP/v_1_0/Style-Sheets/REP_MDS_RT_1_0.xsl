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
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSSIER_TYPE'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSSIER_ID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SAVED'"/></xsl:call-template></TD>
				</TR>
				<TR>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/dossier_type" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover">HC6-024-<xsl:apply-templates select="/descendant-or-self::application_info/dossier_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/last_saved_date" /></span> </TD>
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
							<div class="panel-body">
								<div class="row">
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURING_COMPANY_ID'"></xsl:with-param></xsl:call-template>:&#160;</strong>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/manufacturing_company_id"/></span>
									</div>
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURING_CONTACT_ID'"></xsl:with-param></xsl:call-template>:&#160;</strong>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/manufacturing_contact_id"/></span>
									</div>
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_COMPANY_ID'"></xsl:with-param></xsl:call-template>:&#160;</strong>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/regulatory_company_id"/></span>
									</div>
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_CONTACT_ID'"></xsl:with-param></xsl:call-template>:&#160;</strong>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/regulatory_contact_id"/></span>
									</div>
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACTIVITY_LEAD'"></xsl:with-param></xsl:call-template>:&#160;</strong>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/regulatory_activity_lead"/></span>
									</div>
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACTIVITY_TYPE'"></xsl:with-param></xsl:call-template>:&#160;</strong>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/regulatory_activity_type"/></span>
									</div>
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Transaction_Desc'"></xsl:with-param></xsl:call-template>:&#160;</strong>
										<span class="mouseHover"><xsl:call-template name="getLabel"><xsl:with-param name="node" select="/descendant-or-self::application_info/description_type"/></xsl:call-template></span>
									</div>
									<xsl:if test="/descendant-or-self::application_info/device_class != ''">
										<div class="col-xs-6">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Device_Class'"></xsl:with-param></xsl:call-template>:&#160;</strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/device_class"/></span>
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
													<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="current()"/></xsl:call-template>
													<span class="mouseHover">
														<xsl:call-template name="hp-label"><xsl:with-param name="code" select="name()"/></xsl:call-template>
													</span>
												</div>
											</xsl:if>
										</xsl:for-each>
									</div>
								</xsl:if>
								<div class="row">
									<xsl:if test="/descendant-or-self::application_info/proposed_licence_name != ''">
										<div class="col-xs-10">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Proposed_Licence_Name'"></xsl:with-param></xsl:call-template>:&#160;<br/></strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/proposed_licence_name"/></span>
										</div>
									</xsl:if>
									<xsl:if test="/descendant-or-self::application_info/application_number != ''">
										<div class="col-xs-6">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Application_Number'"></xsl:with-param></xsl:call-template>:&#160;</strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/application_number"/></span>
										</div>
									</xsl:if>

									<xsl:if test="/descendant-or-self::application_info/device_name != ''">
										<div class="col-xs-6">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_NAME'"></xsl:with-param></xsl:call-template>:&#160;</strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/device_name"/></span>
										</div>
									</xsl:if>
									<xsl:if test="/descendant-or-self::application_info/request_date != ''">
										<div class="col-xs-6">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MEETING_ID'"></xsl:with-param></xsl:call-template>:&#160;</strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/meeting_id"/></span>
										</div>
										<div class="col-xs-6">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Date_of_Request'"></xsl:with-param></xsl:call-template>:&#160;</strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/request_date"/></span>
										</div>
									</xsl:if>
									<xsl:if test="/descendant-or-self::application_info/brief_description != ''">
										<div class="col-xs-6">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BRIEF_DESC'"></xsl:with-param></xsl:call-template>:&#160;</strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/brief_description"/></span>
										</div>
									</xsl:if>
									<div class="col-xs-11">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Concat_Transaction_Desc'"></xsl:with-param></xsl:call-template>:&#160;</strong><br/>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/transaction_description"/></span><br/><br/>
									</div>
										<div class="col-xs-11">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_LICENCE'"></xsl:with-param></xsl:call-template>:&#160;</strong>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/licence_number"/></span>
										</div>
									<div class="col-xs-6">
										<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::application_info/has_ddt"/></xsl:call-template>
										<span class="mouseHover">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Device_details_table'"/></xsl:call-template></strong>
										</span>
									</div>
									<div class="col-xs-6">
										<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::application_info/has_app_info"/></xsl:call-template>
										<span class="mouseHover">
											<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'App_Info_XML_Include'"/></xsl:call-template></strong>
										</span>
									</div>
									<div class="col-xs-6">
										<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_SOLICITED'"></xsl:with-param></xsl:call-template>&#160;</strong>
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
									<xsl:if test="count(/descendant-or-self::requester_of_solicited_information/requester/id) > 0 ">
									<xsl:for-each select="/descendant-or-self::requester_of_solicited_information/*">
										<tr><td><xsl:value-of select="./id + 1"/></td>
										<td>
											<xsl:call-template name="getLabel"><xsl:with-param name="node" select="./requester"/></xsl:call-template>
										</td>
										</tr>
									</xsl:for-each>
									</xsl:if>
								</tbody>
							</table>
						</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading"  style="color:#030303; background-color:#f8f8f8;">
							<h3 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_AMOUNT'"/></xsl:call-template></h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-xs-12">
									<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NEW_REVISED_FEES'"/></xsl:call-template>?&#160;</strong>
									<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::transFees/has_fees"/></xsl:call-template></span>
								</div>
								<div class="col-xs-6">
									<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BILLING_COMPANY_ID'"/></xsl:call-template>:&#160;</strong>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::transFees/billing_company_id"/></span>
								</div>
								<div class="col-xs-6">
									<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BILLING_CONTACT_ID'"/></xsl:call-template>:&#160;</strong>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::transFees/billing_contact_id"/></span>
								</div>
								<div class="col-xs-12">
									<div class="alert alert-info">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPLETED_FEE_REQUIRED'"/></xsl:call-template>
									</div>
								</div>
							</div>
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
	<xsl:template name="hp-checkbox">
		<xsl:param name="value" select="/.."/>
		<span class="c-checkbox">
		<xsl:choose>
			<xsl:when test="$value = 'yes'">
				X
			</xsl:when>
			<xsl:otherwise>
				&#160;&#160;
			</xsl:otherwise>
		</xsl:choose>
		</span>
	</xsl:template>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="no" externalpreview="yes" url="file:///c:/Users/hcuser/Downloads/hcreprtm-2019-05-14-1105.xml" htmlbaseurl="" outputurl="file:///c:/SPM/test/TRANSACTION.html" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="cssFile" value="'file:///C:\Users\hcuser\git\XSLT\Medical-Device-REP\v_1_0\Style-Sheets/ip400.css'"/>
			<parameterValue name="labelFile" value="'file:///C:\Users\hcuser\git\XSLT\Medical-Device-REP\v_1_0\Style-Sheets/hp-ip400-labels.xml'"/>
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