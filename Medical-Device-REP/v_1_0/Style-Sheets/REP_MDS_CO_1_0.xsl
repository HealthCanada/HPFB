<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="script.xsl" ?>
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
					<xsl:value-of select="$cssLookup/css/*"/>
				</style>
			</head>
            <body>
<!--				<xsl:if test="count(DEVICE_COMPANY_ENROL) &gt; 0"> <xsl:apply-templates select="DEVICE_COMPANY_ENROL"></xsl:apply-templates> </xsl:if>-->
				<xsl:call-template name="DEVICE_COMPANY_ENROL"/>
			</body>
		</html>
	</xsl:template>
	
	<!-- Company Enrolment -->
	<xsl:template name="DEVICE_COMPANY_ENROL">
		<h1><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_TEMPLATE'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h1>
		<div class="well well-sm" >
			<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
				<TR>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'APPL_STATUS'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ENROL_VERSION'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SAVED'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_ID'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></TD>
				</TR>
				<TR>
					<TD style="text-align: center;"> <span  class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="/descendant-or-self::general_information/status" /></xsl:call-template></span> </TD>
					<TD style="text-align: center;"> <span  class="mouseHover"><xsl:value-of select="/descendant-or-self::general_information/enrol_version" /></span> </TD>
					<TD style="text-align: center;"> <span  class="mouseHover"><xsl:value-of select="/descendant-or-self::general_information/last_saved_date" /></span> </TD>
					<TD style="text-align: center;"> <span  class="mouseHover"><xsl:value-of select="substring(/descendant-or-self::general_information/company_id,2,6)" /></span> </TD>
				</TR>
			</TABLE>
		</div>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_COMPANY_ENROL'"/></xsl:call-template></h2>
				</div>
				
				<div class="panel-body">
					<xsl:if test="/descendant-or-self::general_information/amend_reasons != ''">
					<section class="panel panel-default" >
						<div class="panel-heading">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Reason_Amendment'"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
							<div class="row">&#160;
							<div class="col-xs-5">
								<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::general_information/amend_reasons/manufacturer_name_change"/></xsl:call-template>
								<span class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Change_Name'"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-5">
								<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::general_information/amend_reasons/manufacturer_address_change"/></xsl:call-template>
								<span class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Change_Address'"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-5">
								<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::general_information/amend_reasons/facility_change"/></xsl:call-template>
								<span class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Change_facility'"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-5">
								<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::general_information/amend_reasons/other_change"/></xsl:call-template>
								<span class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'OTHER'"/></xsl:call-template>
								</span>
							</div>
							</div>
							<xsl:if test="/descendant-or-self::general_information/amend_reasons/other_change = 'yes'">
								<div class="col-xs-10">
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SYSTEM_OTHER'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::general_information/amend_reasons/other_details"/></span>
								</div>
							</xsl:if>
						</div>
					</section>
					</xsl:if>
					<section class="panel panel-default" >
							<div class="panel-body">
							<div class="col-sm-12">
								<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Are_Licenses_Transfered'"/></xsl:call-template>? &#160;</strong>
								<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::general_information/are_licenses_transfered"/></xsl:call-template></span>
							</div>
							</div>
					</section>
					<section class="panel panel-default" >
							<div class="panel-heading">
								<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADDR_INFO'"/></xsl:call-template></h2>
							</div>
							<div class="panel-body">
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'I_CompanyName'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::address/company_name"/></span>
								</div>
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STREET_SUITE'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::address/address"/></span>
								</div>
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CITY_TOWN'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::address/city"/></span>&#160;&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PROVINCE'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover">
										<xsl:choose>
											<xsl:when test="(/descendant-or-self::address/country/@id = 'CAN') or (/descendant-or-self::address/country/@id = 'USA')">
												<xsl:value-of select="/descendant-or-self::address/prov_lov"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="/descendant-or-self::address/prov_text"/>
											</xsl:otherwise>
										</xsl:choose>
									</span>&#160;&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COUNTRY'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::address/country"/>
<!--										<xsl:choose>
											<xsl:when test="$language = 'fra'">
												<xsl:value-of select="/descendant-or-self::address/country/@label_fr"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="/descendant-or-self::address/country/@label_en"/>
											</xsl:otherwise>
										</xsl:choose>-->
									</span>
								</div>
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'POSTAL_ZIP'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::address/postal"/></span>
								</div>
							</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACT_INFO'"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
							<xsl:apply-templates select="/descendant-or-self::contacts/contact"/>
						</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REPPRIMARY'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
								<div class="row">&#160;
									<div class="col-xs-10">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'THIRD_PARTY_ENROL'"></xsl:with-param></xsl:call-template>?&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::primary_contact/is_third_party"/></span>
									</div>
								<xsl:choose>
								<xsl:when test="/descendant-or-self::primary_contact/is_third_party = 'yes'">
									<div class="col-xs-5">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_ID_REP'"></xsl:with-param></xsl:call-template>?&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::primary_contact/rep_contact_company_id"/></span>
									</div>
									<div class="col-xs-5">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACT_ID_REP'"></xsl:with-param></xsl:call-template>?&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::primary_contact/rep_contact_id"/></span>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="col-xs-10">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REP_CONTACT_NAME'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::primary_contact/rep_contact_name"/></span>
									</div>
								</xsl:otherwise>
								</xsl:choose>
								</div>
						</div>
					</section>
					<xsl:if test="/descendant-or-self::general_information/amend_reasons/manufacturer_name_change = 'yes' or /descendant-or-self::general_information/amend_reasons/manufacturer_address_change = 'yes' or /descendant-or-self::general_information/amend_reasons/facility_change = 'yes' or /descendant-or-self::general_information/are_licenses_transfered = 'yes'">
					<section class="panel panel-default" >
						<div class="panel-heading">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Company_Administrative_Changes'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-xs-12">
									<div class="alert alert-info">
										<span><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADMIN_CHANGE_NOTE2'"/></xsl:call-template></span>
									</div>
								</div>
							</div>
							<div class="row">&#160;
								<div class="col-xs-5">
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'All_Licence_Number'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:value-of select="/descendant-or-self::administrative_changes/all_licence_numbers"/></span>
								</div>
							</div>
							<div class="row">&#160;
								<div class="col-xs-10">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Is_there_change_name'"></xsl:with-param></xsl:call-template>:&#160;</label>
								<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::administrative_changes/is_regulatory_change"/></xsl:call-template></span>
								</div>
							</div>
							<xsl:if test="/descendant-or-self::administrative_changes/is_regulatory_change = 'yes'">
								<div class="row">&#160;
									<div class="col-sm-5">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NEW'"/></xsl:call-template>&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_ID'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="substring(/descendant-or-self::administrative_changes/new_company_id, 2, 6)"/></span>
									</div>
									<div class="col-sm-5">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NEW'"/></xsl:call-template>&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACT_ID'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::administrative_changes/new_contact_id"/></span>
									</div>
								</div>
								<div class="row">&#160;
									<div class="col-sm-10">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NEW'"/></xsl:call-template>&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Contact_Name'"></xsl:with-param></xsl:call-template>:&#160;</label>
										<span class="mouseHover"><xsl:value-of select="/descendant-or-self::administrative_changes/new_contact_name"/></span>
									</div>
								</div>
							</xsl:if>
							<div class="row">
								<div class="col-xs-12">
									<div class="alert alert-info">
										<span><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADMIN_CHANGE_NOTE1'"/></xsl:call-template></span>
									</div>
								</div>
							</div>
						</div>
					</section>
					</xsl:if>

				</div>
			</div>
		</section>
	</xsl:template>
	<xsl:template match="contacts/contact">
		<section class="panel panel-default" >
			<div class="panel-heading">
				<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACT_DETAILS'"/></xsl:call-template>&#160;<xsl:value-of select="id + 1"/></h2>
			</div>
			<div class="panel-body">
				<div class="row">&#160;
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SALUTATION'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="salutation"/></span>&#160;&#160;
					</div>
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACT_ID'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="contact_id"/></span>&#160;&#160;
					</div>
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STATUS'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="status"/></span>
					</div>
				</div>
				<div class="row">&#160;
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FIRSTNAME'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="first_name"/></span>&#160;&#160;
					</div>
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INITIALS'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="initials"/></span><xsl:if test="initials = ''">&#160;&#160;&#160;&#160;</xsl:if>&#160;&#160;
					</div>
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LASTNAME'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="last_name"/></span>
					</div>
				</div>
				<div class="row">&#160;
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LANGCORRESPOND'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="language"/></span>&#160;&#160;
					</div>
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'JOBTITLE'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="job_title"/></span>
					</div>
				</div>
				<div class="row">&#160;
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PHONENUMBER'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="phone_number"/></span>&#160;&#160;
					</div>
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PHONE_EXT'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:if test="phone_extension = ''">&#160;&#160;&#160;&#160;</xsl:if>
					<xsl:value-of select="contact/phone_extension"/></span>
					</div>
					<div class="col-sm-3">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FAX_NUMBER'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="fax_number"/></span>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EMAIL'"/></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="email"/></span>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="..\..\..\..\..\Downloads\hcrepcom-k111111-2-0 (1).xml" htmlbaseurl="" outputurl="..\..\..\..\..\..\..\SPM\test\mds_company.html" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="cssFile" value="'file:///C:/Users/hcuser/git/XSLT/Regulatory-Enrolment-Process-REP/v_1_0/Style-Sheets/ip400.css'"/>
			<parameterValue name="labelFile" value="'file:///C:/Users/hcuser/git/XSLT/Regulatory-Enrolment-Process-REP/v_1_0/Style-Sheets/hp-ip400-labels.xml'"/>
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