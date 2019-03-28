<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:param name="labelFile" select="'./hp-ip400-labels_2_2.xml'"/>
	<xsl:param name="cssFile" select="'./ip400.css'"/>
	<xsl:param name="language" select="'eng'"/>
	<xsl:variable name="labelLookup" select="document($labelFile)"/>
	<xsl:variable name="cssLookup" select="document($cssFile)"/>
    <xsl:template match="/">
        <html>
			<head>
				<meta http-equiv="X-UA-Compatible" content="IE=9"/>
				<style type="text/css">
					<xsl:value-of select="$cssLookup/css"/>
				</style>
			</head>
            <body>
                <xsl:if test="count(DOSSIER_ENROL) &gt; 0"> <xsl:apply-templates select="DOSSIER_ENROL"></xsl:apply-templates> </xsl:if>
            </body>
        </html>
    </xsl:template>
	
    <!-- Dossier Enrolment -->
    <xsl:template match="DOSSIER_ENROL">
		<div class="container">
        <h1><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSSIER_TEMP'"/></xsl:call-template></h1>
		<div class="well well-sm" >
			<table border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
				<tr>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EnrolStatus'"/></xsl:call-template></td>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ENROL_VERSION'"/></xsl:call-template></td>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SAVED'"/></xsl:call-template></td>
					<td style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierID'"/></xsl:call-template></td>
				</tr>
				<tr>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="application_type" /></span></td>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="enrolment_version" /></span></td>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="date_saved" /></span></td>
					<td style="text-align: center;"><span class="mouseHover"><xsl:apply-templates select="dossier_id" /></span></td>
				</tr>
			</table>
		</div>
        <section class="panel panel-primary mrgn-tp-lg">
            <header class="panel-heading clearfix">
               <h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierInfo'"/></xsl:call-template></h2>
			</header>
            <div class="panel-body">

				<div class="well well-sm" >
                    <div class="row">
						<div class="col-xs-4">
							<label><xsl:call-template name="hp-label">
								<xsl:with-param name="code" select="'A_DossierType'"/>
							</xsl:call-template>:&#160;
							<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;"><xsl:value-of select="dossier_type"/></span></label>
						</div>
						<div class="col-xs-4">
							<label><xsl:call-template name="hp-label">
								<xsl:with-param name="code" select="'B_CompanyID'"/>
							</xsl:call-template>:&#160;
							<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;"><xsl:value-of select="company_id"/></span></label>
						</div>
                    </div>
                    <div class="row">
						<div class="col-xs-12">
							<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'D_ProductName'"/>
								</xsl:call-template>:&#160;
							<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;"><xsl:value-of select="product_name"/></span></label>
						</div>
					</div>
                    <div class="row">
						<div class="col-xs-12">
							<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'E_ProperCommonNonProrietaryName'"/>
								</xsl:call-template>:&#160;
							<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;"><xsl:value-of select="common_name"/></span></label>
						</div>
					</div>
                    <div class="row">
						<div class="col-xs-12">
							<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'DrugUse'"/>
								</xsl:call-template>:&#160;
							<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;">
								<xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="drug_use"/>
								</xsl:call-template>
							</span></label>
						</div>
					</div>
                    <div class="row">
						<div class="col-xs-12">
							<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'G_RelatedInfo'"/>
								</xsl:call-template>:&#160;</label>
						</div>
						<div class="col-xs-12">
							<span class="padLeft3 normalWeight mouseHover" style="font-weight:100;"><xsl:call-template name="break"><xsl:with-param name="text" select="related_information"/></xsl:call-template></span>
						</div>
					</div>
                    <div class="row">
						<div class="col-xs-12">
							<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'H_Therapeutic'"/>
								</xsl:call-template>:&#160;</label>
							<div class="padLeft3">
								<table border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
								<thead>
								<tr><th>
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'THERAPEUTIC_CLASSIFICATION_NAME'"/></xsl:call-template></label>
								</th></tr>
								</thead>
								<tbody>
				                        <xsl:for-each select="therapeutic_class_list/therapeutic_class">
											<tr>
												<xsl:if test="position() mod 2 = 0">
													<xsl:attribute name="style">background-color:#b0bed9;</xsl:attribute>
												</xsl:if>
												<td><span class="mouseHover"><xsl:value-of select="."/></span></td>
											</tr>
										</xsl:for-each>
								</tbody>
								</table>
							</div>
						</div>
					</div>
                    <div class="row">
						<div class="col-xs-12">
							<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'I_IsCaRefProduct'"/>
								</xsl:call-template>&#160;
							<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;">
							<xsl:choose>
							<xsl:when test=" is_ref_product = 'Y'">
								<xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'Yes'"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'No'"/>
								</xsl:call-template>
							</xsl:otherwise>
							</xsl:choose>
							</span></label>
						</div>
					</div>
					<xsl:if test=" is_ref_product = 'Y'">
                    <div class="row">
						<div class="col-xs-12">
							<ul style="list-style:none;">
							<li>
							<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'CaRefProduct'"/>
								</xsl:call-template></label>
							</li>
							<li>
								<ul style="list-style: none;">
									<li>
									<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'I_BrandName'"/>
								</xsl:call-template>:&#160;
									<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;"><xsl:value-of select="cdn_ref_product/brand_name"/></span></label>
									</li>
									<li>
									<label><xsl:call-template name="hp-label">
									<xsl:with-param name="code" select="'I_CompanyName'"/>
								</xsl:call-template>:&#160;
									<span class="padLeft3 nowrap normalWeight mouseHover" style="font-weight:100;"><xsl:value-of select="cdn_ref_product/company_name"/></span></label>
									</li>
								</ul>
							</li>
							</ul>
						</div>
					</div>

					</xsl:if>
				</div>
            </div>
        </section>
        <section class="panel panel-primary mrgn-tp-lg">
            <header class="panel-heading clearfix">
               <h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REP_CONTACT_INFO'"/></xsl:call-template></h2>
			</header>
            <div class="panel-body">
				<div class="well well-sm" >
						<table border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
						<tbody>
							<xsl:for-each select="contact_record">
								<tr>
									<xsl:choose>
									<xsl:when test="position() mod 2 = 1">
										<td colspan="6" style="background-color:grey;color:white;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REPPRIMARY'"/></xsl:call-template></td>
									</xsl:when>
									<xsl:otherwise>
<!--										<td colspan="6" style="background-color:grey;color:white;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REPSECONDARY'"/></xsl:call-template></td>-->
									</xsl:otherwise>
									</xsl:choose>
								</tr>
								<tr>
									<xsl:if test="position() mod 2 = 0">
										<xsl:attribute name="style">background-color:#b0bed9;</xsl:attribute>
									</xsl:if>
									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SALUTATION'"/></xsl:call-template></td>
									<td style="padding-left:2px;"><span class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="./rep_contact_details/salutation"/></xsl:call-template></span></td>
									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'JOBTITLE'"/></xsl:call-template></td>
									<td style="padding-left:2px;"><span class="mouseHover"><xsl:value-of select="rep_contact_details/job_title"/></span></td>
									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LANGCORRESPOND'"/></xsl:call-template></td>
									<td style="padding-left:2px;"><span class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="rep_contact_details/language_correspondance"/></xsl:call-template></span></td>
								</tr>
								<tr>
									<xsl:if test="position() mod 2 = 0">
										<xsl:attribute name="style">background-color:#b0bed9;</xsl:attribute>
									</xsl:if>
									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FIRSTNAME'"/></xsl:call-template></td>
									<td style="padding-left:2px;"><span class="mouseHover"><xsl:value-of select="rep_contact_details/given_name"/></span></td>
									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INITIALS'"/></xsl:call-template></td>
									<td style="padding-left:2px;"><span class="mouseHover"><xsl:value-of select="rep_contact_details/initials"/></span></td>
									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LASTNAME'"/></xsl:call-template></td>
									<td style="padding-left:2px;"><span class="mouseHover"><xsl:value-of select="rep_contact_details/surname"/></span></td>
								</tr>
								<tr>
									<xsl:if test="position() mod 2 = 0">
										<xsl:attribute name="style">background-color:#b0bed9;</xsl:attribute>
									</xsl:if>
<!--									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ONE_ROLE'"/></xsl:call-template></td>
									<td style="padding-left:2px;"><span class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="concat('ROLE_', rep_contact_role)"/></xsl:call-template></span></td>-->
									<td style="padding-left:2px; font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EMAIL'"/></xsl:call-template></td>
									<td colspan="5" style="padding-left:2px;"><span class="mouseHover"><xsl:value-of select="rep_contact_details/email"/></span></td>
								</tr>
							</xsl:for-each>
						</tbody>
						</table>
				</div>
			</div>
		</section>
		</div>
    </xsl:template>
	<xsl:template name="break">
	  <xsl:param name="text" select="string(.)"/>
	  <xsl:choose>
	    <xsl:when test="contains($text, '&#xa;')">
	      <xsl:value-of select="substring-before($text, '&#xa;')"/>
	      <br/>
	      <xsl:call-template name="break">
	        <xsl:with-param name="text" select="substring-after($text, '&#xa;')"/>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$text"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
	<xsl:template name="hp-label">
		<xsl:param name="code" select="/.."/>
		<xsl:variable name="value" select="$labelLookup/SimpleCodeList/row[code=$code]/*[name()=$language]"/>
		<xsl:if test="$value"><xsl:value-of select="$value"/></xsl:if>
		<xsl:if test="not($value)">Error: code missing:(<xsl:value-of select="$code"/> in <xsl:value-of select="$labelFile"/>)</xsl:if>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="file:///e:/ip400Demo/tmp/hcrepdo-e123456-1-0.xml" htmlbaseurl="" outputurl="..\..\..\..\..\..\..\..\SPM\test\dossier.html" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="cssFile" value="'file:///C:/Users/hcuser/git/HC-IMSD/REP/xslt/ip400.css'"/>
			<parameterValue name="labelFile" value="'C:\Users\hcuser\git\HC-IMSD\REP\xslt\hp-ip400-labels.xml'"/>
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