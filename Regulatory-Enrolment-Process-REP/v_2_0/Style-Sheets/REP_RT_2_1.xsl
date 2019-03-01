<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:param name="labelFile" select="'./hp-ip400-labels.xml'"/>
	<xsl:param name="cssFile" select="'./ip400.css'"/>
	<xsl:param name="language" select="'eng'"/>
	<xsl:variable name="labelLookup" select="document($labelFile)"/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
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
				<xsl:if test="count(TRANSACTION_ENROL) &gt; 0"> <xsl:apply-templates select="TRANSACTION_ENROL"></xsl:apply-templates> </xsl:if>
			</body>
		</html>
	</xsl:template>
	
	<!-- Transaction Enrolment -->
	<xsl:template match="TRANSACTION_ENROL">
		<h1><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TRANSACTION_INFO_TMPL'"/></xsl:call-template></h1>
					<div class="well well-sm" >
						<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
							<TR>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_ID'"/></xsl:call-template></TD>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSSIER_TYPE'"/></xsl:call-template></TD>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierID'"/></xsl:call-template></TD>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DateLastSaved'"/></xsl:call-template></TD>
							</TR>
							<TR>
								<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="ectd/company_id" /></span> </TD>
								<TD style="text-align: center;"> <span class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:apply-templates select="ectd/dossier_type" /></xsl:with-param></xsl:call-template></span> </TD>
								<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="ectd/dossier_id" /></span> </TD>
								<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="date_saved" /></span> </TD>
							</TR>
						</TABLE>
					</div>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_INFO'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">										
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PRODUCT_NAME'"/></xsl:call-template>&#160; </label>
								<span class="mouseHover">
									<xsl:value-of select="ectd/product_name"/>
								</span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TRANSACTION_TYPE'"/></xsl:call-template>&#160; </label>
								<span class="mouseHover">
									<xsl:choose>
									<xsl:when test=" translate(./transaction_type, $smallcase, $uppercase) = 'NEW'">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NEW'"/></xsl:call-template>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_THIRD_PARTY'"/></xsl:call-template>&#160; </label>
												<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_third_party"/></xsl:call-template>
												</span>
											</div>
											<xsl:if test="is_third_party = 'Y'">
											<div class="col-xs-11 alert alert-info">
												<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_THIRD_PARTY_INFO'"/></xsl:call-template>
											</div>
											</xsl:if>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_PRIORITY'"/></xsl:call-template>&#160; </label>
												<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_priority"/></xsl:call-template>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_NOC'"/></xsl:call-template>&#160; </label>
												<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_noc"/></xsl:call-template>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_ADMIN_SUB'"/></xsl:call-template>&#160; </label>
												<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_admin_sub"/></xsl:call-template>
												</span>
											</div>
										</div>
										<xsl:if test="is_admin_sub = 'Y'">
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADMIN_SUB_TYPE'"/></xsl:call-template>&#160; </label>
												<span class="mouseHover">
													<xsl:choose>
														<xsl:when test="$language = 'eng'"><xsl:value-of select="sub_type/en"/></xsl:when>
														<xsl:otherwise><xsl:value-of select="sub_type/fr"/></xsl:otherwise>
													</xsl:choose>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADMIN_SUB_TYPE_DESC'"/></xsl:call-template>&#160; </label>
												<ul><li><span class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="concat(sub_type/id,'_li')"/></xsl:with-param></xsl:call-template></span></li></ul>
											</div>
										</div>
										<div class="row alert alert-info col-xs-12">
											<span class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="concat(sub_type/id, '_note')" disable-output-escaping="yes"/></xsl:with-param></xsl:call-template>
											</span>
										</div>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="hp-label">
											<xsl:with-param name="code" select="'EXISTING'"/>
										</xsl:call-template>
									</xsl:otherwise>
									</xsl:choose>
								</span>
							</div>
						</div>
					</div>

					<div class="well well-sm" >
							<div class="row">
								<header class="panel-heading" >
									<h4 class="panel-title" ><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LIFECYCLE_TITLE'"/></xsl:call-template></h4>
								</header>								
								
								<div class="panel-body" >
									<table border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
										<xsl:for-each select="ectd/lifecycle_record">
											<tr>
												<td colspan="6"> 
													<fieldset>
														<legend><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LIFECYCLE_RECORD'"/></xsl:call-template></legend>
														<div class="row">
															<div class="form-group col-md-6">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTROL_NUM'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="control_number"/></span></label>
															</div>
															<div class="form-group col-md-6">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_ACTIVITY_LEAD'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="./sequence_activity_lead"/></xsl:with-param></xsl:call-template></span></label>
															</div>
														</div>
														<div class="row">
														</div>
														<div class="row">
															<div class="form-group col-md-6">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACTIVITY_TYPE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="./sequence_activity_type"/></xsl:with-param></xsl:call-template></span></label>
															</div>
															<div class="form-group col-md-6">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_TRANSACTION_DESC'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="./sequence_description_value"/></xsl:with-param></xsl:call-template></span></label>
															</div>
														</div>
														<div class="row">
															<xsl:choose>
															<xsl:when test="./sequence_description_value = 'UNSOLICITED_DATA'">
															<div class="form-group col-md-12">
																<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BRIEF_DESC'"/></xsl:call-template>:&#160;</label>
																<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./sequence_details"/></span>
															</div>
															</xsl:when>
															<xsl:otherwise>
															<div class="form-group col-md-6">
																<xsl:if test="./sequence_from_date != ''">
																	<xsl:choose>
																	<xsl:when test="./sequence_to_date = ''">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATED'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./sequence_from_date"/></span></label>
																	</xsl:when>
																	<xsl:otherwise>
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'START_DATE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./sequence_from_date"/></span></label>
																	</xsl:otherwise>
																	</xsl:choose>
																</xsl:if>
																<xsl:if test="./sequence_year != ''">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'YEAR_OF_CHANGE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./sequence_year"/></span></label>
																</xsl:if>
															</div>
															<div class="form-group col-md-6">
																<xsl:if test="./sequence_to_date != ''">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'END_DATE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./sequence_to_date"/></span></label>
																</xsl:if>
																<xsl:if test="./sequence_version != ''">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'VERSION_NO'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./sequence_version"/></span></label>
																</xsl:if>
															</div>
															</xsl:otherwise>
															</xsl:choose>
															<xsl:if test="./sequence_year != ''">
															<div class="form-group col-md-12">
																<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LIST_DESC'"/></xsl:call-template>:&#160;</label>
																<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./sequence_details"/></span>
															</div>
															</xsl:if>
														</div>
													</fieldset>
												</td>
											</tr>
										</xsl:for-each>
									</table>
								</div>
							</div>
						</div>
						

					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_SOLICITED'"/></xsl:call-template>&#160; </label>
								<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_solicited"/></xsl:call-template>
								</span>
							</div>
						</div>
						<xsl:if test="is_solicited = 'Y'">
							<div class="row">
								<div class="col-xs-12">
									<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SOLICITED_RQ'"/></xsl:call-template>:&#160; </label>
									<span class="mouseHover"> <xsl:apply-templates select="solicited_requester" /> </span>
									<ol>
										<xsl:for-each select="solicited_requester_record">
											<li><span class="mouseHover"><xsl:value-of select="./solicited_requester"/></span></li>
										</xsl:for-each>
									</ol>
								</div>
							</div>
						</xsl:if>
					</div>
					
					<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PROJ_MANAGER_NAME'"/></xsl:call-template>: </h4>
					
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<span class="mouseHover"> <xsl:apply-templates select="regulatory_project_manager1" /> </span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<span class="mouseHover"> <xsl:apply-templates select="regulatory_project_manager2" /> </span>
							</div>
						</div>
					</div>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_FEE_TRANSACTION'"/></xsl:call-template>&#160; </label>
								<span class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_fees"/></xsl:call-template>
								</span>
							</div>
						</div>
					</div>

				</div>		
			</div>
			<xsl:if test="is_fees = 'Y'">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_AMOUNT'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SUB_CLASS'"/></xsl:call-template>:&#160; </label>
								<span class="mouseHover">
								<xsl:choose>
								<xsl:when test="$language = 'fra'">
									<xsl:value-of select="fee_details/submission_class/fr"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="fee_details/submission_class/en"/>
								</xsl:otherwise>
								</xsl:choose>
								</span>
								<label>&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_AMOUNT'"/></xsl:call-template>:&#160;</label>
								<span class="mouseHover">$<xsl:value-of select="fee_details/submission_class/fee"/></span>
							</div>
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_DESCRIPTION'"/></xsl:call-template>:&#160;</label>
								<span class="mouseHover">
								<xsl:choose>
								<xsl:when test="$language = 'fra'">
									<xsl:value-of select="fee_details/submission_class/description_fr"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="fee_details/submission_class/description_en"/>
								</xsl:otherwise>
								</xsl:choose>
								</span>
							</div>
						</div>
					</div>
					<div class="well well-sm" >
						<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Mitigation_Measures'"/></xsl:call-template></strong>
						<div class="panel">
							<div class="row">
								<div class="col-xs-12">
									<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Mitigation_Measures_For'"/></xsl:call-template></strong>
									<div class="col-sm-10">
									<span class="mouseHover">
									<xsl:choose>
									<xsl:when test="$language = 'fra'">
										<xsl:value-of select="fee_details/mitigation/mitigation_type/fr"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="fee_details/mitigation/mitigation_type/en"/>
									</xsl:otherwise>
									</xsl:choose>
									</span>
									</div>
								</div>
								<xsl:if test="fee_details/mitigation/certify_organization = 'Y'">
								<div class="col-xs-12">
									<strong><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/mitigation/certify_organization = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;" class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Small_Business_1'"/></xsl:call-template>
								</span>&#160;&#160;</strong>
								</div>
								<div class="col-xs-12">
									<div class="col-xs-10">
									<div class="col-xs-10">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Small_Business_Note'"/></xsl:call-template>
									</div>
									</div>
								</div>
								<div class="col-xs-12">
									<strong><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/mitigation/small_business_fee_application = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;" class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Small_Business_2'"/></xsl:call-template>
								</span>&#160;&#160;</strong>
								</div>
								<div class="col-xs-12">
									<strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'First_Submit'"/></xsl:call-template>&#160;?&#160;&#160;
										<span style="font-weight:normal;" class="mouseHover">
										<xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="fee_details/mitigation/first_submission"/></xsl:call-template>
										</span>
									</strong>
								</div>
								</xsl:if>
								<xsl:if test="fee_details/mitigation/certify_goverment_organization = 'Y'">
								<div class="col-xs-12">
									<strong><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/mitigation/certify_goverment_organization = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;" class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Goverment_1'"/></xsl:call-template>
								</span>&#160;&#160;</strong>
								</div>
								</xsl:if>
								<xsl:if test="fee_details/mitigation/certify_funded_health_institution = 'Y'">
								<div class="col-xs-12">
									<strong><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/mitigation/certify_funded_health_institution = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;" class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Public_1'"/></xsl:call-template>
								</span>&#160;&#160;</strong>
								</div>
								<div class="col-xs-12">
									<div class="col-xs-10">
									<div class="col-xs-10">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Public_Note'"/></xsl:call-template>
									</div>
									</div>
								</div>
								</xsl:if>
								<xsl:if test="fee_details/mitigation/certify_urgent_health_need = 'Y'">
								<div class="col-xs-12">
									<strong><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/mitigation/certify_urgent_health_need = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;" class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Urgent_Public_1'"/></xsl:call-template>
								</span>&#160;&#160;</strong>
								</div>
								<div class="col-xs-12">
									<div class="col-xs-10">
									<div class="col-xs-10">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Urgent_Public_Note'"/></xsl:call-template>
									</div>
									</div>
								</div>
								</xsl:if>
							</div>
						</div>
					</div>


				</div>
			</div>
			</xsl:if>
			
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_ACT_CONTACT'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">
					<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_CONTACT_THIS'"/></xsl:call-template></h4>
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_INFO'"/></xsl:call-template>: </label>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_NOABBREV'"/></xsl:call-template></label>
							</div>
							<div class="col-xs-12">
								<span class="mouseHover"><xsl:apply-templates select="company_name" /> </span>
							</div>
						</div>
					</div>
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADDRESS_INFO'"/></xsl:call-template>: </label>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STREET_SUITE'"/></xsl:call-template></label>
								<span class="mouseHover"> <xsl:apply-templates select="regulatory_activity_address/street_address" /> </span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CITY_TOWN'"/></xsl:call-template> </label>
								<span class="mouseHover"> <xsl:apply-templates select="regulatory_activity_address/city" /> </span>
								<label> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PROVINCE'"/></xsl:call-template>&#160;&#160; </label>
								<span class="mouseHover"> <xsl:choose><xsl:when test="(regulatory_activity_address/country = 'CAN') or (regulatory_activity_address/country = 'USA')"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="regulatory_activity_address/province_lov" /></xsl:call-template></xsl:when><xsl:otherwise><xsl:apply-templates select="regulatory_activity_address/province_text" /></xsl:otherwise></xsl:choose> </span>
								<label> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COUNTRY'"/></xsl:call-template>&#160;&#160; </label>
								<span class="mouseHover"> 
								<xsl:choose>
								<xsl:when test="$language = 'fra'">
									<xsl:value-of select="regulatory_activity_address/country/@label_fr"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="regulatory_activity_address/country/@label_en"/>
								</xsl:otherwise>
								</xsl:choose>
								</span>
							</div>
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'POSTAL_ZIP'"/></xsl:call-template> </label>
								<span class="mouseHover"> <xsl:apply-templates select="regulatory_activity_address/postal_code" /> </span>
							</div>
						</div>
					</div>
					<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_REP_THIS'"/></xsl:call-template>: </h4>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-3"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SALUTATION'"/></xsl:call-template>&#160;&#160;
								<span class="mouseHover" style="font-weight:normal;"> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="regulatory_activity_contact/salutation" /></xsl:call-template> </span></label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'JOBTITLE'"/></xsl:call-template>&#160;&#160; 
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/job_title" /> </span></label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LANGCORRESPOND'"/></xsl:call-template>&#160;&#160; 
								<span class="mouseHover" style="font-weight:normal;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="regulatory_activity_contact/language_correspondance"/></xsl:call-template></span></label>
							</div>
							<div class="col-xs-12">
								<label class="col-xs-3"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FIRSTNAME'"/></xsl:call-template>&#160;&#160;
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/given_name" /> </span> </label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INITIALS'"/></xsl:call-template>&#160;&#160;
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/initials" /> </span> </label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LASTNAME'"/></xsl:call-template>&#160;&#160;
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/surname" /> </span> </label>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-6"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PHONENUMBER'"/></xsl:call-template>&#160;&#160;
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/phone_num" /> </span>&#160;&#160;
								<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EXTENSION'"/></xsl:call-template> &#160;&#160;
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/phone_ext" /> </span> </label>
								<label class="col-xs-3">&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FAX_NUMBER'"/></xsl:call-template>&#160;&#160; 
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/fax_num" /> </span></label>
							</div>
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACTEMAIL'"/></xsl:call-template>&#160;&#160;
								<span class="mouseHover" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/email" /> </span></label>
							</div>
						</div>
					</div>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" confirm_regulatory_contact = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span class="mouseHover">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONFIRM_REGULATORY'"/></xsl:call-template>
								</span></label>
							</div>
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
		<xsl:when test="$value = 'Y'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Yes'"/></xsl:call-template>
		</xsl:when>
		<xsl:when test="$value = 'N'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'No'"/></xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'UNKNOWN'"/></xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:transform><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="file:///e:/ip400Demo/tmp/hcreprt-2019-02-26-0933.xml" htmlbaseurl="" outputurl="..\..\..\..\..\..\..\SPM\test\TRANSACTION.html" processortype="saxon8"
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