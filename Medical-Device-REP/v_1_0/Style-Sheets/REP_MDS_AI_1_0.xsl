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
		<h1><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'APPLICATION_INFO_TMPL'"/></xsl:call-template></h1>
		<div class="well well-sm" >
			<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
				<TR>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURE_CO_ID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SAVED'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'QMSC_NO'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LICENCE_APP_TYPE'"/></xsl:call-template></TD>
				</TR>
				<TR>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/company_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/dossier_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/last_saved_date" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="/descendant-or-self::application_info/qmsc_number" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/licence_application_type" /></span> </TD>
				</TR>
			</TABLE>
		</div>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'APPLICATION_INFO'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">
					<section class="panel panel-default" >
							<header class="panel-heading" style="color:#030303; background-color:#f8f8f8;">
								<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PLACE_OF_USE'"/></xsl:call-template></h2>
							</header>
							<div class="panel-body">
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_IVDD'"></xsl:with-param></xsl:call-template>&#160;</label>
									<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/is_ivdd"/></xsl:call-template></span>
								</div>
								<xsl:choose>
								<xsl:when test="/descendant-or-self::application_info/is_ivdd = 'yes'">
									<div class="row">&#160;
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_FOR_HOME'"></xsl:with-param></xsl:call-template>&#160;</label>
										<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/is_home_use"/></xsl:call-template></span>
									</div>
									<div class="row">&#160;
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_FOR_CARE'"></xsl:with-param></xsl:call-template>&#160;</label>
										<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/is_care_point_use"/></xsl:call-template></span>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="row">&#160;
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'has_drug'"></xsl:with-param></xsl:call-template>?&#160;</label>
										<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/has_drug"/></xsl:call-template></span>
									</div>
									<xsl:if test="/descendant-or-self::application_info/has_drug = 'yes'">
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_NUMBER_TYPE'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/has_din_npn"/></span>
										</div>
									</xsl:if>
									<xsl:choose>
									<xsl:when test="/descendant-or-self::application_info/has_din_npn/@id = 'din'">
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_DIN'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/din"/></span>
										</div>
									</xsl:when>
									<xsl:when test="/descendant-or-self::application_info/has_din_npn/@id = 'npn'">
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_NPN'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/npn"/></span>
										</div>
									</xsl:when>
									<xsl:otherwise>
										<div class="row">&#160;
											<div class="col-xs-12 alert alert-INFO">
												<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_OTHER_INFO'"/></xsl:call-template>
											</div>
										</div>
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_BRD_NAME'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/drug_name"/></span>
										</div>
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_ACT_INGREDIENT'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/active_ingredients"/></span>
										</div>
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_MANUFACTURER'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/manufacturer"/></span>
										</div>
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_COMPLIANCE'"></xsl:with-param></xsl:call-template>:&#160;</label>
										</div>
										<div class="row">&#160;
											<div class="col-xs-3">
												<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::application_info/compliance_usp = 'yes'"/></xsl:call-template>
												<span class="mouseHover">
													<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_USP'"/></xsl:call-template>
												</span>
											</div>
											<div class="col-xs-3">
												<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::application_info/compliance_gmp = 'yes'"/></xsl:call-template>
												<span class="mouseHover">
													<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_GMP'"/></xsl:call-template>
												</span>
											</div>
											<div class="col-xs-3">
												<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::application_info/compliance_other = 'yes'"/></xsl:call-template>
												<span class="mouseHover">
													<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_OTHER'"/></xsl:call-template>
												</span>
											</div>
										</div>
										<div class="row">&#160;
											<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_SPECIFY'"></xsl:with-param></xsl:call-template>:&#160;</label>
											<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/other_pharmacopeia"/></span>
										</div>
									</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
								</xsl:choose>
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ANY_RADIATION'"></xsl:with-param></xsl:call-template>&#160;</label>
									<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/is_emit_radiation"/></xsl:call-template></span>
								</div>
							</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading"  style="color:#030303; background-color:#f8f8f8;">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_HISTORY'"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
							<div class="row">&#160;
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'HAS_PRE_AUTH_IN_CA'"/></xsl:call-template></label>
							</div>
							<div class="row">&#160;
								<div class="col-xs-3">
									<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::application_info/provision_mdr_it = 'yes'"/></xsl:call-template>
									<span class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INVST_TST'"/></xsl:call-template>
									</span>
								</div>
								<div class="col-xs-3">
									<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="/descendant-or-self::application_info/provision_mdr_sa = 'yes'"/></xsl:call-template>
									<span class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SPL_ACC'"/></xsl:call-template>
									</span>
								</div>
							</div>
							<div class="row">&#160;
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'application_number'"></xsl:with-param></xsl:call-template>:&#160;</label>
								<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/application_number"/></span>
							</div>
							<div class="row">&#160;
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'sap_request_number'"></xsl:with-param></xsl:call-template>:&#160;</label>
								<span class="mouseHover"><xsl:value-of select="/descendant-or-self::application_info/sap_request_number"/></span>
							</div>
						</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading"  style="color:#030303; background-color:#f8f8f8;">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPATIBLE_DEVICE'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
							<xsl:call-template name="compatibleDevices"><xsl:with-param name="values" select="/descendant-or-self::devices"/></xsl:call-template>
						</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading"  style="color:#030303; background-color:#f8f8f8;">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LIST_MANUFACTURE_STANDARDS'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
							<div class="row">&#160;
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DECLARATION_COMFORMITY'"></xsl:with-param></xsl:call-template>:&#160;</label>
								<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/declaration_conformity"/></xsl:call-template></span>
							</div>
							<xsl:if test="application_info/declaration_conformity = 'no'">
								<div class="row">&#160;
									<div class="col-xs-12 alert alert-INFO">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DECLARATION_COMFORMITY_NO'"/></xsl:call-template>
									</div>
								</div>
							</xsl:if>
						</div>
					</section>
					<section class="panel panel-default" >
						<div class="panel-heading"  style="color:#030303; background-color:#f8f8f8;">
							<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BIO_MATERIAL_CONTAIN'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h2>
						</div>
						<div class="panel-body">
							<div class="row">&#160;
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BIO_DEVICE_RECOMBINANT'"></xsl:with-param></xsl:call-template>:&#160;</label>
								<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/has_recombinant"/></xsl:call-template></span>
							</div>
							<xsl:if test="/descendant-or-self::application_info/has_recombinant = 'yes'">
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BIO_DEVICE_HUMAN_ANIMAL'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/is_animal_human_sourced"/></xsl:call-template></span>
								</div>
							</xsl:if>
							<xsl:if test="/descendant-or-self::application_info/is_animal_human_sourced = 'yes'">
								<div class="row">&#160;
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BIO_IS_DEHP_BPA'"></xsl:with-param></xsl:call-template>:&#160;</label>
									<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="/descendant-or-self::application_info/is_listed_idd_table"/></xsl:call-template></span>
								</div>
							</xsl:if>
							<xsl:if test="count(/descendant-or-self::materials/material/@id) > 0">
								<section class="panel panel-default" >
									<div class="panel-heading"  style="color:#030303; background-color:#f8f8f8;">
										<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BIO_MATERIAL_ATT_TAB'"/><xsl:with-param name="language" select="$language"/></xsl:call-template></h2>
									</div>
									<div class="panel-body">
										<xsl:call-template name="biologicMaterial"><xsl:with-param name="values" select="/descendant-or-self::materials"/></xsl:call-template>
									</div>
								</section>
							</xsl:if>
						</div>
					</section>
				</div>
			</div>
		</section>
	</xsl:template>
	<xsl:template name="biologicMaterial">
		<xsl:param name="values" select="/.."/>
		<xsl:for-each select="$values/material">
			<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BIO_MATERIAL'" /></xsl:call-template>&#160;<xsl:value-of select="position()"/></h4>
			<div class="row">&#160;&#160;&#160;&#160;&#160;&#160;
				<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NAME_OF_MATERIAL'"></xsl:with-param></xsl:call-template>:&#160;</label>
				<span class="mouseHover"><xsl:value-of select="./material_name"/></span>
			</div>
			<div class="row">&#160;&#160;&#160;&#160;&#160;&#160;
				<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NAME_OF_COMPATIBLE'"></xsl:with-param></xsl:call-template>:&#160;</label>
				<span class="mouseHover"><xsl:value-of select="./device_name"/></span>
			</div>
			<div class="row">&#160;&#160;&#160;&#160;&#160;&#160;
				<div class="col-xs-5">
					<label>&#160;&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ORIGIN_COUNTRY'"></xsl:with-param></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="./origin_country"/></span>
				</div>
				<div class="col-xs-5">
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SPECIES_FAMILY'"></xsl:with-param></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="./family_of_species"/></span>
				</div>
			</div>
			<div class="row">&#160;&#160;&#160;&#160;&#160;&#160;
				<div class="col-xs-5">
					<label>&#160;&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TISSUE_TYPE'"></xsl:with-param></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="./tissue_substance_type"/></span>
				</div>
				<xsl:if test="./tissue_type_other_details != ''">
					<div class="col-xs-5">
						<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TISSUE_TYPE_OTHER'"></xsl:with-param></xsl:call-template>:&#160;</label>
						<span class="mouseHover"><xsl:value-of select="./tissue_type_other_details"/></span>
					</div>
				</xsl:if>
			</div>
			<div class="row">&#160;&#160;&#160;&#160;&#160;&#160;
				<div class="col-xs-5">
					<label>&#160;&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DERIVATIVE'"></xsl:with-param></xsl:call-template>:&#160;</label>
					<span class="mouseHover"><xsl:value-of select="./derivative"/></span>
				</div>
				<xsl:if test="./derivative_other_details != ''">
					<div class="col-xs-5">
						<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DERIVATIVE_OTHER'"></xsl:with-param></xsl:call-template>:&#160;</label>
						<span class="mouseHover"><xsl:value-of select="./derivative_other_details"/></span>
					</div>
				</xsl:if>
			</div>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="compatibleDevices">
		<xsl:param name="values" select="/.." />
		<xsl:for-each select="$values/device">
			<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INTERDEPENDENT_DEVICE'" /></xsl:call-template>&#160;<xsl:value-of select="position()"/></h4>
			<div class="row">&#160;&#160;&#160;&#160;&#160;&#160;
				<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPATIBLE_DEV_NM'"></xsl:with-param></xsl:call-template>:&#160;</label>
				<span class="mouseHover"><xsl:value-of select="./device_name"/></span>
			</div>
			<div class="row">&#160;&#160;&#160;&#160;&#160;&#160;
				<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEVICE_LICENCE'"></xsl:with-param></xsl:call-template>:&#160;</label>
				<span class="mouseHover"><xsl:value-of select="./licence_number"/></span>
			</div>
		</xsl:for-each>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="..\..\..\..\..\Downloads\hcrepaim-2019-04-23-0125.xml" htmlbaseurl="" outputurl="..\..\..\..\..\..\..\SPM\test\mds_appInfo.html" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="cssFile" value="'file:///C:/Users/hcuser/git/XSLT/Regulatory-Enrolment-Process-REP/v_2_0/Style-Sheets/ip400.css'"/>
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