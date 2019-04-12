<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:param name="labelFile" select="'./hp-ip400-labels.xml'"/>
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
            <body >
				<xsl:if test="count(DRUG_PRODUCT_ENROL) &gt; 0"> <xsl:apply-templates select="DRUG_PRODUCT_ENROL"></xsl:apply-templates> </xsl:if>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="DRUG_PRODUCT_ENROL">
		<h1>Product Infromation Template: Regulatory Enrolment Process (REP)</h1>
		<div class="well well-sm" >
			<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
				<TR>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ENROL_VERSION'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_ID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierID'"/></xsl:call-template></TD>
					<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DateLastSaved'"/></xsl:call-template></TD>
				</TR>
				<TR>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="enrolment_version" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="company_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="dossier_id" /></span> </TD>
					<TD style="text-align: center;"> <span class="mouseHover"><xsl:apply-templates select="date_saved" /></span> </TD>
				</TR>
			</TABLE>
		</div>
		<section>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DRUG_PRODUCT'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">										
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12 form-group">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PRODUCT_NAME'"/></xsl:call-template></label>
								<div class="col-xs-12"><span style="font-weight:normal;" class="mouseHover"><xsl:value-of select="product_name"/></span></div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 form-group">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PROPER_NAME'"/></xsl:call-template></label>
								<div class="col-xs-12"><span style="font-weight:normal;" class="mouseHover"><xsl:value-of select="proper_name"/></span></div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADDRESS_NOC'"/></xsl:call-template>:</label>
								<table>
									<tr>
										<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="manufacturer"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MANUFACTURER_SPONSOR'"/></xsl:call-template>
										</span>
										</td>
										<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="mailing"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACT_MAILING'"/></xsl:call-template>
										</span>
										</td>
									</tr>
									<tr>
										<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="this_activity"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'THIS_ACTIVITY'"/></xsl:call-template>
										</span>
										</td>
										<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="importer"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CANADIAN_IMPORTER'"/></xsl:call-template>
										</span>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="row"><br/>
						</div>
						<div class="row">
						<div class="col-sm-12 form-group">
							<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IMPORTER'"/></xsl:call-template></label>
							<TABLE class="table dataTable table-bordered">
								<thead>
								<tr>
									<th style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IMP_COMP_ID'"/></xsl:call-template></th>
									<th style="text-align: center;font-weight:bold;" colspan="2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IMPORTER_COMPANY_NAME_IF'"/></xsl:call-template></th>
								</tr>
								</thead>
								<xsl:for-each select="importer_record">
								<TR>
									<TD><span class="mouseHover"><xsl:apply-templates select="./importer_company_id" /></span> </TD>
									<TD colspan="2"> <span class="mouseHover"><xsl:apply-templates select="./importer_company_name" /></span> </TD>
								</TR>
								</xsl:for-each>
							</TABLE>
						</div>
						</div>
						<div class="row"><br/>
						</div>
						<div class="row">
							<div class="col-xs-12 form-group">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DrugUse'"/></xsl:call-template>:&#160;
								<span style="font-weight:normal;" class="mouseHover"><xsl:choose><xsl:when test="$language = 'eng'"><xsl:value-of select="drug_use/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="drug_use/@label_fr"/></xsl:otherwise></xsl:choose></span>
								</label>
							</div>
						</div>
						<xsl:if test="drug_use = 'DISINFECT'">
							<div class="row">
							<div class="col-xs-12 form-group">
							<table>
							<tbody>
								<tr><td colspan="3"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DISINFECTANT_TYPE'"/></xsl:call-template></label></td></tr>
								<tr>
									<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="disinfectant_type/hospital"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'HOSPITAL'"/></xsl:call-template>
										</span>
									</td>
									<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="disinfectant_type/food_processing"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FOOD_PROCESSING'"/></xsl:call-template>
										</span>
									</td>
									<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="disinfectant_type/medical_instruments"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MEDICAL_INSTRUMENTS'"/></xsl:call-template>
										</span>
									</td>
								</tr>
								<tr>
									<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="disinfectant_type/domestic"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOMESTIC'"/></xsl:call-template>
										</span>
									</td>
									<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="disinfectant_type/barn"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BARN'"/></xsl:call-template>
										</span>
									</td>
									<td>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="disinfectant_type/institutional_industrial"/></xsl:call-template>
										<span style="font-weight:normal;" class="mouseHover">
											<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INSTITUTIONAL_INDUSTRIAL'"/></xsl:call-template>
										</span>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
							</div>
						</xsl:if>
						<div class="row">
							<div class="col-xs-12 form-group">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SCHEDULE_PRESC_STATUS'"/></xsl:call-template></label>
								<div class="col-xs-12 checkbox checkbox-pi">
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="is_sched_c"/></xsl:call-template>
									<span style="font-weight:normal;margin-left:15px;" class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SCHEDULE_C'"/></xsl:call-template>
									</span>
								</div>
								<div class="col-xs-12 checkbox checkbox-pi">
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="is_sched_d"/></xsl:call-template>
									<span style="font-weight:normal;margin-left:15px;" class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SCHEDULE_D'"/></xsl:call-template>
									</span>
								</div>
								<div class="col-xs-12 checkbox checkbox-pi">
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="is_prescription_drug_list"/></xsl:call-template>
									<span style="font-weight:normal;margin-left:15px;" class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PRESCRIPTION_DRUG'"/></xsl:call-template>
									</span>
								</div>
								<div class="col-xs-12 checkbox checkbox-pi">
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="is_regulated_cdsa"/></xsl:call-template>
									<span style="font-weight:normal;margin-left:15px;" class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REGULATED_CDSA'"/></xsl:call-template>
									</span>
								</div>
								<div class="col-xs-12 checkbox checkbox-pi">
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="is_non_prescription_drug"/></xsl:call-template>
									<span style="font-weight:normal;margin-left:15px;" class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_NON_PRESCRIPTION_DRUG'"/></xsl:call-template>
									</span>
								</div>
								<div class="col-xs-12 checkbox checkbox-pi">
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="is_sched_a"/></xsl:call-template>
									<span style="font-weight:normal;margin-left:15px;" class="mouseHover">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NON_PRESC_SCHEDULE_A'"/></xsl:call-template>
									</span>
								</div>
								<xsl:if test="is_sched_a = 'Y'">
								<div class="col-xs-12 form-group">
									<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SCHEDA_DETAILS'"/></xsl:call-template></label>
									<div class="panel-body" style="border: 1px solid black;">
										<div class="row">
											<p style="padding-left:20px;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SCHEDA_DESCRIPTION'"/></xsl:call-template></p>
										</div>
										<div class="col-xs-12">
										<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DIN_FULL'"/></xsl:call-template></label>
											:&#160;&#160;<span class="mouseHover"><xsl:value-of select="schedule_a_group/din_number"/></span>
										</div>
										<div class="col-xs-12 form-group" style="padding-left: 15px;">
											<div class="col-xs-12">
												<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SCHEDA_DISEASE'"/></xsl:call-template></label>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/acute_alcohol"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACUTEALCOHOL'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/acute_anxiety"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACUTEANXIETY'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/acute_infectious"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACUTERESP'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/acute_inflammatory"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACUTEINFLAM'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/acute_psychotic"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACUTEPSYCHOTIC'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
			<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/addiction"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADDICTION'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/ateriosclerosis"/></xsl:call-template>
														<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ATERIOSCLEROSIS'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/appendicitis"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'APPENDICITIS'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/asthma"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ASTHMA'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/cancer"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CANCER'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/congest_heart_fail"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'HEARTCONGEST'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/convulsions"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONVULSIONS'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/dementia"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEMENTIA'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/depression"/></xsl:call-template>
															<span style="font-weight:normal;">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEPRESSION'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/diabetes"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DIABETES'"/></xsl:call-template>
															</span>
														</strong>
													</div>
											</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/gangrene"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'GANGRENE'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
					<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/glaucoma"/></xsl:call-template>
														<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'GLAUCOMA'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/haematologic_bleeding"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BLEEDINGDISORDERS'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/hepatitis"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'HEPATITIS'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/hypertension"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'HYPERTENSION'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/nausea_pregnancy"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NAUSEAPREG'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/obesity"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'OBESITY'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/rheumatic_fever"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'RHEUMATICFEVER'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/septicemia"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SEPTICEMIA'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/sex_transmit_disease"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SEXDISEASE'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/strangulated_hernia"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STRANGHERNIA'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/thrombotic_embolic_disorder"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'THROMBOTICDISORDER'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
												<div class="row checkbox">
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/thyroid_disease"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'THYROIDDISEASE'"/></xsl:call-template>
															</span>
														</strong>
													</div>
													<div class="col-md-4">
														<strong>
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="schedule_a_group/ulcer_gastro"/></xsl:call-template>
															<span style="font-weight:normal;" class="mouseHover">
																<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'UCLERGASTRO'"/></xsl:call-template>
															</span>
														</strong>
													</div>
												</div>
											</div>
											<div class="col-xs-12 form-group" style="padding-left: 15px;">
												<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SCHEDA_CLAIMS'"/></xsl:call-template></label>
												<div class="row">
													<div class="col-xs-12">
														<span class="mouseHover"><xsl:value-of select="schedule_a_group/sched_a_claims_ind_details"/></span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								</xsl:if>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 form-group">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PROP_INDICATION'"/></xsl:call-template></label>
								<div class="col-xs-12">
									<span class="mouseHover"><xsl:value-of select="proposed_indication"/></span>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FORMULATION'"/></xsl:call-template></label>
								<div class="form-group">
									<ul class="nav nav-tabs">
										<li tabindex="0" class="active" id="tab0"><a href="#tabpanel0"><strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FORMULATIONS'"/></xsl:call-template></strong></a>
										</li>
									</ul>
									<div class="tabpanels">
										<div class="active" id="tabpanel0">
											<table class="table dataTable table-bordered table-hover table-condensed table-striped">
											<tbody>
												<xsl:for-each select="formulation_group/formulation_details">
													<tr>
														<td colspan="3"> 
															<fieldset>
																<legend><h4>&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FORMULATION_DETAILS'"/></xsl:call-template>&#160;<xsl:value-of select="formulation_id"/></h4></legend>
																<div>
																	<section class="panel panel-default">
																		<div class="panel-body">
																			<div class="row well well-sm">
																				<div class="form-group col-md-12">
																				<label>A. <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FORMULATION_NAME'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="formulation_name"/></span></label>
																				</div>
																			</div>
																		</div>
																	</section>
																</div>

																<div>
																	<section class="panel panel-default">
																		<div class="panel-body">
																			<div class="row well well-sm">
																				<div class="form-group col-md-12">
																				<label>B. <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSAGE_FORM'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:choose><xsl:when test="$language = 'eng'"><xsl:value-of select="dosage_form_group/dosage_form/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="dosage_form_group/dosage_form/@label_fr"/></xsl:otherwise></xsl:choose></span>&#160;<span><xsl:value-of select="dosage_form_group/dosage_form_other"/></span></label>
																				</div>
																			</div>
																		</div>
																	</section>
																</div>
																<div>
																	<section class="panel panel-default">
																		<header class="panel-heading"><h3 class="panel-title ng-binding">C.&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INGREDIENTS'"/></xsl:call-template></h3></header>
																		<div class="panel-body">
																			<div>
																				<table class="table dataTable table-bordered table-hover table-condensed table-striped" id="expand-table-141">
																				<tbody>
																					<xsl:for-each select="formulation_ingredient">
																						<tr>
																							<td colspan="6">
															<fieldset>
																<legend><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INGRED_DETAILS'"/></xsl:call-template>&#160;<xsl:value-of select="position()"/></legend>
																<div class="row">
																	<div class="col-md-6">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ONE_ROLE'"/></xsl:call-template>:&#160;
																	<span style="font-weight: normal;" class="mouseHover">
																	<xsl:choose>
																	<xsl:when test="ingredient_role = 'MED'">
																		<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ONE_ROLE_MED'"/></xsl:call-template>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ONE_ROLE_NON_MED'"/></xsl:call-template>
																	</xsl:otherwise>
																	</xsl:choose>
																	</span></label>
																	</div>
																	<xsl:if test="ingredient_role = 'NONMED'">
																		<div class="col-md-6">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'VARIANT_NAME'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="variant_name"/></span></label>
																		</div>
																		<div class="col-md-6">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PURPOSE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="purpose"/></span></label>
																		</div>
																	</xsl:if>
																	<div class="col-md-6">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ING_NAME'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="ingredient_name"/></span></label>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-6"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CAS_NUM'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="cas_number"/></span></label></div>
																	<div class="col-md-6"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STANDARD'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="ingred_standard"/></span></label></div>
																</div>
																<div class="row">
																	<div class="col-md-6"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STRENGTH'"/></xsl:call-template>:&#160;
																	<span style="font-weight: normal;" class="mouseHover"><xsl:choose><xsl:when test="$language = 'eng'"><xsl:value-of select="./strength/operator/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="./strength/operator/@label_en"/></xsl:otherwise></xsl:choose></span>&#160;
																	<xsl:if test="strength/operator = 'RA'">
																		<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'RANGE_LOWER_LIMIT'"/></xsl:call-template></span>:&#160;
																	</xsl:if>
																	<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="strength/data1"/></span>&#160;
																	<xsl:choose>
																	<xsl:when test="units_other != 'null' and units_other != ''">
																		<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="units_other"/></span>&#160;
																	</xsl:when>
																	<xsl:otherwise>
																		<span style="font-weight: normal;" class="mouseHover"><xsl:choose><xsl:when test="$language ='eng'"><xsl:value-of select="units/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="units/@label_fr"/></xsl:otherwise></xsl:choose></span>
																	</xsl:otherwise>
																	</xsl:choose>
																	<xsl:if test="strength/operator = 'RA'">&#160;&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'RANGE_UPPER_LIMIT'"/></xsl:call-template></span>:&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="strength/data2"/></span>&#160;
																		<xsl:choose>
																		<xsl:when test="per_units_other_details != 'null' and per_units_other_details != ''">
																			<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="units_other"/></span>&#160;
																		</xsl:when>
																		<xsl:otherwise>
																			<span style="font-weight: normal;" class="mouseHover"><xsl:choose><xsl:when test="$language ='eng'"><xsl:value-of select="units/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="units/@label_fr"/></xsl:otherwise></xsl:choose></span>
																		</xsl:otherwise>
																		</xsl:choose>
																	</xsl:if>
																	</label>
																	</div>
																		<xsl:variable name="perUnit">
																			<xsl:choose><xsl:when test="$language ='eng'"><xsl:value-of select="per/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="per/@label_fr"/></xsl:otherwise></xsl:choose>
																		</xsl:variable>
																	<div class="col-md-3">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PER_STRENGTH'"/></xsl:call-template></label>&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="per_value"/></span>&#160;
																		<xsl:choose>
																		<xsl:when test="per_units_other_details != 'null' and per_units_other_details != ''">
																				<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="per_units_other_details"/></span>
																		</xsl:when>
																		<xsl:otherwise>
																				<span style="font-weight: normal;" class="mouseHover"><xsl:choose><xsl:when test="$language ='eng'"><xsl:value-of select="per_units/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="per_units/@label_fr"/></xsl:otherwise></xsl:choose></span>
																		</xsl:otherwise>
																		</xsl:choose>
																		
																	</div>
																	<div class="col-md-3"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ISBASE'"/></xsl:call-template>&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_base_calc"/></xsl:call-template></span>
																	</label></div>
																</div>
																<div class="row">
																	<div class="col-md-6"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_NANO_MATERIAL'"/></xsl:call-template>&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_nanomaterial"/></xsl:call-template></span>
																	</label></div>
																	<div class="col-md-6"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ANIMAL_HUMAN_SOURCED'"/></xsl:call-template>&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_human_animal_src"/></xsl:call-template></span>
																	</label></div>
																</div>
																<xsl:if test="is_nanomaterial = 'Y'">
																<div class="row">
																	<div class="col-md-12"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NANO_MATERIAL'"/></xsl:call-template>:&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:choose><xsl:when test="$language ='eng'"><xsl:value-of select="nanomaterial/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="nanomaterial/@label_fr"/></xsl:otherwise></xsl:choose></span>
																		<xsl:if test="nanomaterial_details != 'null' and nanomaterial_details != ''">&#160;&#160;
																			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NANO_MATERIAL_OTHER'"/></xsl:call-template>:&#160;
																			<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="nanomaterial_details"/></span>
																		</xsl:if>
																	</label></div>
																</div>
																</xsl:if>
															</fieldset>

																							</td>
																						</tr>
																					</xsl:for-each>
																				</tbody>
																				</table>
																			</div>
																		</div>
																	</section>
																</div>
																<div>
																	<section class="panel panel-default">
																		<header class="panel-heading"><h3 class="panel-title ng-binding">D.&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_ANIMAL_HUMAN_MATERIAL'"/></xsl:call-template>&#160;<span style="font-weight: normal;"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_animal_human_material"/></xsl:call-template></span></h3></header>
																		<div class="panel-body">
																			<xsl:if test="is_animal_human_material = 'Y'">
																			<div>
																				<table class="table dataTable table-bordered table-hover table-condensed table-striped" id="expand-table-141">
																				<tbody>
																					<xsl:for-each select="material_ingredient">
																						<tr>
																							<td colspan="4">
															<fieldset>
																<legend><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MATERIAL_DETAILS'"/></xsl:call-template>&#160;<xsl:value-of select="position()"/></legend>
																<div class="row">
																	<div class="col-md-6">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MATERIAL_NAME'"/></xsl:call-template>:&#160;<span class="normalWeight mouseHover"><xsl:value-of select="./ingredient_name"/></span></label>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-3">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CAS_NUM'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./cas_number"/></span></label>
																	</div>
																	<div class="col-md-3">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STANDARD'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./cas_number"/></span></label>
																	</div>
																	<div class="col-md-3">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PRESENT_IN_FINAL'"/></xsl:call-template>?&#160;
																		<span style="font-weight: normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="in_final_container"/></xsl:call-template></span></label>
																	</div>
																</div>

															</fieldset>
																							</td>
																						</tr>
																					</xsl:for-each>
																				</tbody>
																				</table>
																			</div>
																			</xsl:if>
																		</div>
																	</section>
																</div>
																<div>
																	<section class="panel panel-default">
																		<header class="panel-heading"><h3 class="panel-title ng-binding">E.&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTAINER_TYPES'"/></xsl:call-template></h3></header>
																		<div class="panel-body">
																			<div>
																				<table class="table dataTable table-bordered table-hover table-condensed table-striped" id="expand-table-141">
																				<tbody>
																					<xsl:for-each select="container_group/container_details">
																						<tr>
																							<td colspan="4">
															<fieldset>
																<legend><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTAINER_TYPE_DETAILS'"/></xsl:call-template>&#160;<xsl:value-of select="position()"/></legend>
																<div class="row">
																	<div class="col-md-12">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTAINER_TYPE'"/></xsl:call-template>:&#160;<span class="normalWeight mouseHover"><xsl:value-of select="container_type"/></span></label>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-6">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PACKAGE_SIZE'"/></xsl:call-template>:&#160;<span class="normalWeight mouseHover"><xsl:value-of select="package_size"/></span></label>
																	</div>
																	<div class="col-md-6">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SHELF_LIFE'"/></xsl:call-template>:&#160;
																		<span class="normalWeight mouseHover"><xsl:value-of select="shelf_life_number"/></span>&#160;
																		<span class="normalWeight mouseHover"><xsl:choose><xsl:when test="$language = 'fra'"><xsl:apply-templates select="shelf_life_unit/@label_fr" /></xsl:when><xsl:otherwise><xsl:apply-templates select="shelf_life_unit/@label_en" /></xsl:otherwise></xsl:choose></span>
																		</label>
																	</div>
																</div>
																<div class="row">
																</div>
																<div class="row">
																	<div class="col-md-6">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TEMP_RANGE'"/></xsl:call-template>:&#160;
																		<span class="normalWeight mouseHover"><xsl:value-of select="temperature_min"/></span>&#160;&#160;
																		<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TO'"/></xsl:call-template>:&#160;
																		<span class="normalWeight mouseHover"><xsl:value-of select="temperature_max"/></span>&#160;
																		<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CELSIUS'"/></xsl:call-template>
																		</label>
																	</div>
																</div>
															</fieldset>
																							</td>
																						</tr>
																					</xsl:for-each>
																				</tbody>
																				</table>
																			</div>
																		</div>
																	</section>
																</div>

																<div>
																	<section class="panel panel-default">
																		<header class="panel-heading"><h3 class="panel-title ng-binding">F.&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ROA_TITLE'"/></xsl:call-template></h3></header>
																		<div class="panel-body">
																			<div>
																				<table class="table dataTable table-bordered" id="expand-table-141">
																				<thead>
																					<tr>
																						<th style="background-color:white !important;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ROA_LBL'"/></xsl:call-template></th>
																						<th style="background-color:white !important;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'OTHER_ROA_DETAILS'"/></xsl:call-template></th>
																					</tr>
																				</thead>
																				<tbody>
																					<xsl:for-each select="roa_group/roa_details">
																						<tr>
																							<td><span class="mouseHover"><xsl:choose><xsl:when test="$language = 'fra'"><xsl:apply-templates select="./roa/@label_fr" /></xsl:when><xsl:otherwise><xsl:apply-templates select="./roa/@label_en" /></xsl:otherwise></xsl:choose></span></td>
																							<td><span class="mouseHover"><xsl:value-of select="./roa_other"/>&#160;</span></td>
																						</tr>
																					</xsl:for-each>
																				</tbody>
																				</table>
																			</div>
																		</div>
																	</section>
																</div>
																<div>
																	<section class="panel panel-default">
																		<header class="panel-heading"><h3 class="panel-title">G.&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COUNTRIES_MANUFACT'"/></xsl:call-template></h3></header>
																		<div class="panel-body">
																			<div>
																				<table class="table dataTable table-bordered" id="expand-table-141">
																				<thead>
																					<tr>
																						<th style="background-color:white !important;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COUNTRY_MAN'"/></xsl:call-template></th>
																					</tr>
																				</thead>
																				<tbody>
																					<xsl:for-each select="country_group/country_manufacturer">
																						<tr>
																							<td><span class="mouseHover"><xsl:choose><xsl:when test="$language = 'fra'"><xsl:apply-templates select="./@label_fr" /></xsl:when><xsl:otherwise><xsl:apply-templates select="./@label_en" /></xsl:otherwise></xsl:choose></span></td>
																						</tr>
																					</xsl:for-each>
																				</tbody>
																				</table>
																			</div>
																		</div>
																	</section>
																</div>

															</fieldset>
															</td>
													</tr>
												</xsl:for-each>
											</tbody>
											</table>
										</div>
<div class="row"><br /></div>		
									<ul class="nav nav-tabs">
										<li tabindex="1" class="active" id="tab1"><a href="#tabpanel1"><strong><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'APPENDIX4'"/></xsl:call-template></strong></a>
										</li>
									</ul>
										<div class="active" id="tabpanel1">
											<table class="table dataTable table-bordered table-hover table-condensed table-striped">
											<tbody>
												<xsl:for-each select="appendix4_group">
													<tr>
														<td colspan="2"> 
															<fieldset>
																<legend><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ING_DETAILS'"/></xsl:call-template>&#160;<xsl:value-of select="ingredient_id"/></legend>
																<div class="row">
																	<div class="col-md-12">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INGRED_MAT_NAME'"/></xsl:call-template>:&#160;<span style="font-weight: normal;" class="mouseHover"><xsl:value-of select="./ingredient_name"/></span></label>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-12">
																		<strong style="float:left"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SOURCED'"/></xsl:call-template>:&#160;
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="human_sourced"/></xsl:call-template>
																		&#160;<span style="font-weight:normal;" class="mouseHover">
																		<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'HUMAN'"/></xsl:call-template>
																		</span>&#160;&#160;&#160;
				<xsl:call-template name="hp-checkbox"><xsl:with-param name="value" select="animal_sourced"/></xsl:call-template>
																		<span style="font-weight:normal;" class="mouseHover">
																			&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ANIMAL'"/></xsl:call-template>
																		</span>
																		</strong>
																	</div>
																</div>
																<xsl:if test=" ./human_sourced = 'Y' or ./animal_sourced = 'Y'">
																<div class="row">
																	<div class="panel-default" style="margin-left:10px; margin-right:10px;">
																		<header><h3 style="font-weight:300; padding-left:5px"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TISSUES_FLUIDS_SRCS'"/></xsl:call-template></h3></header>
																		<div class="panel-body">
																			<table class="table dataTable table-bordered table-hover table-condensed table-striped">
																				<thead>
																					<tr>
																						<th style="background-color:white !important;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SYSTEM_TYPE'"/></xsl:call-template></th>
																						<th style="background-color:white !important;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SYSTEM_DETAILS'"/></xsl:call-template></th>
																						<th style="background-color:white !important;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SYSTEM_OTHER'"/></xsl:call-template></th>
																					</tr>
																				</thead>
																				<tbody>
																					<xsl:for-each select="tissues_fluids_section/*[1]">
																						<xsl:variable name="tissueName" select="name(.)"/>
																						<xsl:variable name="TISSUE_NAME"><xsl:call-template name="upperCase"><xsl:with-param name="string" select="$tissueName"/></xsl:call-template></xsl:variable>
																						<tr>
																							<td><span  class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="$TISSUE_NAME"/></xsl:call-template></span></td>
																							<td>
																								<xsl:for-each select="*">
																									<span class="mouseHover">
																									<xsl:if test=" . = 'Y'">
																									<xsl:variable name="temp" select="name(.)"/>
																									<xsl:if test="$temp != 'other_nervous_details' and $temp != 'other_digestive_details' and $temp != 'other_musculo_skeletal_details' and $temp != 'other_reproductive_details' and $temp != 'other_cardio_respiratory_details' and $temp != 'other_immune_details' and $temp != 'other_skin_glandular_details' and $temp != 'other_fluids_tissues_details'">
																									<xsl:variable name="UpperTEMP"><xsl:call-template name="upperCase"><xsl:with-param name="string" select="$temp"/></xsl:call-template></xsl:variable>
																									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="$UpperTEMP"/></xsl:call-template><br/>
																									</xsl:if>
																									</xsl:if>
																									</span>
																								</xsl:for-each>
																							</td>
																							<td><span class="mouseHover"><xsl:value-of select="*[self::other_nervous_details or self::other_digestive_details or self::other_musculo_skeletal_details or self::other_reproductive_details or self::other_cardio_respiratory_details or self::other_immune_details or self::other_skin_glandular_details or self::other_fluids_tissues_details]"/></span></td>
																						</tr>
																					</xsl:for-each>
																				</tbody>
																				</table>
																		</div>
																		<xsl:if test="animal_sourced = 'Y'">
																			<header><h3 style="font-weight:300; padding-left:5px"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ANIMAL_SRCS'"/></xsl:call-template></h3></header>
																			<div class="panel-body">
																			<table class="table dataTable table-bordered table-hover table-condensed table-striped">
																			<thead>
																					<th style="background-color:white !important;"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ANIMAL_TYPE'"/></xsl:call-template></label></th>
																					<th style="background-color:white !important;"><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ANIMAL_TYPE_LBL'"/></xsl:call-template></label></th>
																			</thead>
																			<tbody>
																				<xsl:for-each select="animal_sourced_section/animal_src_record">
																				<tr>
																					<td><span class="mouseHover"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="concat('ANIMAL_', animal_type)"/></xsl:call-template></span></td>
																					<td><span class="mouseHover"><xsl:value-of select="animal_detail"/></span></td>
																				</tr>
																				</xsl:for-each>
																			</tbody>
																			</table>
																			<div class="row"><br/>
																			  <div class="col-md-3">
																			  	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_AGE_KNOWN'"/></xsl:call-template>&#160;
																				<span style="font-weight:normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="animal_sourced_section/is_animal_age_known"/></xsl:call-template></span></label>
																			  </div>
																			  <div class="col-md-3">
																			  	<xsl:if test="animal_sourced_section/is_animal_age_known = 'Y'">
																			  	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'AGEANIMALS'"/></xsl:call-template>:&#160;<span style="font-weight:normal;" class="mouseHover"><xsl:value-of select="animal_sourced_section/animal_age"/></span></label>
																				</xsl:if>
																			  </div>
																			  <div class="col-md-6">
																			  	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTROLLEDPOP'"/></xsl:call-template>:&#160;<span style="font-weight:normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="animal_sourced_section/is_controlled_pop"/></xsl:call-template></span></label>
																			  </div>
																			</div>
																			<div class="row"><br/>
																			  <div class="col-md-6">
																			  	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CELLLINE'"/></xsl:call-template>:&#160;<span style="font-weight:normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="animal_sourced_section/is_cell_line"/></xsl:call-template></span></label>
																			  </div>
																			  <div class="col-md-6">
																			  	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BIOTECHDERIVED'"/></xsl:call-template>:&#160;<span style="font-weight:normal;" class="mouseHover"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="animal_sourced_section/is_biotech_derived"/></xsl:call-template></span></label>
																			  </div><br/>
																			</div>
																			<table class="table dataTable table-bordered table-hover table-condensed table-striped">
																			<thead>
																					<th><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ANIMAL_CTRY_ORIGIN'"/></xsl:call-template></label></th>
																					<th><label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'UNKNOWN_COUNTRY_DETAILS'"/></xsl:call-template></label></th>
																			</thead>
																			<tbody>
																				<xsl:for-each select="animal_sourced_section/country_origin_list">
																				<tr>
																					<td><span class="mouseHover"><xsl:choose><xsl:when test="$language = 'eng'"><xsl:value-of select="country_origin/country_with_unknown/@label_en"/></xsl:when><xsl:otherwise><xsl:value-of select="country_origin/country_with_unknown/@label_fr"/></xsl:otherwise></xsl:choose></span></td>
																					<td><span class="mouseHover"><xsl:value-of select="country_origin/unknown_country_details"/></span></td>
																				</tr>
																				</xsl:for-each>
																			</tbody>
																			</table>
																			</div>
																		</xsl:if>

																	</div>
																</div>
																</xsl:if>
															</fieldset>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
											</table>
										</div>
									</div>
								</div>
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
		<xsl:if test="$value"><xsl:value-of select="$value"/></xsl:if>
		<xsl:if test="not($value)">Error: code missing:(<xsl:value-of select="$code"/> in <xsl:value-of select="$labelFile"/>)</xsl:if>
	</xsl:template>
	<xsl:template name="upperCase">
		<xsl:param name="string" select="/.."/>
		<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
		<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
		<xsl:value-of select="translate($string, $smallcase, $uppercase)" />
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
	<xsl:template name="hp-checkbox">
		<xsl:param name="value" select="/.."/>
		<span class="c-checkbox">
		<xsl:choose>
			<xsl:when test="$value = 'Y'">
				X
			</xsl:when>
			<xsl:otherwise>
				&#160;&#160;
			</xsl:otherwise>
		</xsl:choose>
		</span>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="no" externalpreview="yes" url="file:///c:/Users/hcuser/Downloads/hcreppi-2019-04-01-0848.xml" htmlbaseurl="" outputurl="file:///c:/SPM/test/product.html" processortype="saxon8"
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