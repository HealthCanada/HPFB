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

The Initial Developer of the Original Code is Gunther Schadow,
Pragmatic Data LLC. Portions created by Initial Developer are
Copyright (C) 2002-2013 Health Level Seven, Inc. All Rights Reserved.
-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v3="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="v3 xsl">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<xsl:apply-templates mode="EPA" select="." />
	</xsl:template>

	<xsl:template mode="EPA" match="/v3:document">
		<!-- GS: this template needs thorough refactoring -->
		<html>
			<head>
				<meta name="documentId" content="{/v3:document/v3:id/@root}"/>
				<meta name="documentSetId" content="{/v3:document/v3:setId/@root}"/>
				<meta name="documentVersionNumber" content="{/v3:document/v3:versionNumber/@value}"/>
				<meta name="documentEffectiveTime" content="{/v3:document/v3:effectiveTime/@value}"/>
				<title>
					<!-- GS: this isn't right because the title can have markup -->
					<xsl:value-of select="v3:title"/>
				</title>
				<link rel="stylesheet" type="text/css" href="{$css}"/>
			</head>
			<body>
				<table cellpadding="0" class="tableContentAlign3911" style="width:1300px;border:1px solid">
					<tr>
						<td colspan="7">
							<table cellpadding="0" class="tableContentAlign3911" style="width:1300px;margin-top: 0ex;margin-bottom:0ex">
								<tr>
									<td style="text-align:left; font-family: Century Gothic,sans-serif;width:60%">
										Confidential Business Information: Does Not Contain National Security Information(E. O. 12065)
									</td>
									<td style="text-align:right; font-family: Century Gothic,sans-serif;width:40%">
										Form Approved. OMB No. XXXX-XXXX-XX
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table cellpadding="0" class="tableContentAlign3911" style="width:1300px;margin-top: 0ex;margin-bottom:0ex;">
								<tr style="border-top:1px solid">
									<td colspan="4">
										<table cellpadding="0" class="tableContentAlign3911" style="width:1300px;margin-top: 0ex;margin-bottom:0ex">
											<tr>
												<td style="width:15%;text-align:center">
												EPA
												</td>
												<td style="width:31%;border-right:1px solid;text-align:center">
												United States<br/>
												Environmental Protection Agency<br/>
												Wahiongton, DC 20460<br/>
												</td>
												<td style="width:18%;border-right:1px solid">
											A. [] Basic Information <br/>
											   [] Alternative Formulation
												</td>
												<td style="width:18%;border-right:1px solid">
											B. <br/>
											Page [] of []
												</td>
												<td style="width:18%;text-align:center;">
												See Instruction on Back
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style="border-top:1px solid">
									<td colspan="4">
										<table cellpadding="0" class="tableContentAlign3911" style="width:1300px;margin-top: 0ex;margin-bottom:0ex">
											<tr>
												<td>
													<h3 style="text-align:center">Office Of Pesticide Programs (7505C) - Confiendial Statement of Formula</h3>
												</td>
											</tr>
										</table>
									</td>								
								</tr>
								<tr style="border-top:1px solid">
									<td style="width:650px;border-right: 1px solid;">
										<h3 style="margin-left:2ex">
													1.Name and Address Of Appliciant/Registraint (Include Zip Code)
										</h3>
										<div style="background-color: #E8E8E8;padding-left:20px">
											<xsl:apply-templates mode="Name_Address" select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:contactParty"/>
										</div>
									</td>
									<td style="width:650px;" colspan="3">
										<h3 style="margin-left:2ex">
													2.Name and Address Of Producer (Include Zip Code)
										</h3>
										<div style="background-color: #E8E8E8;padding-left:20px">
											<xsl:apply-templates mode="Name_Address" select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:contactParty"/>
										</div>
									</td>
								</tr>
								<tr style="border-top:1px solid">
									<td style="border-right: 1px solid;width:650px">
										<h3 style="margin-left:2ex">
													3.Product Name
										</h3>
										<div style="background-color: #E8E8E8;padding-left:20px">
											<xsl:value-of select="v3:component/v3:structuredBody/v3:component/v3:section/v3:subject/v3:manufacturedProduct/v3:manufacturedProduct/v3:name"/>
										</div>
									</td>
									<td style="width:650px">
										<table cellpadding="0" class="tableContentAlign3911" style="width:650px;margin-top: 0ex;margin-bottom:0ex">
											<tr>
												<td style="border-right: 1px solid;"> 
													<h3 style="margin-left:2ex">
																4.Registration No/File Symbol
													</h3>
												</td>
												<td style="border-right: 1px solid;">
													<h3 style="margin-left:2ex">
																5.EPA Product Mgr/Team No.
													</h3>
												</td>
												<td>
													<h3 style="margin-left:2ex">
																6.Country Where Formulated
													</h3>
												</td>
											</tr>
											<tr style="border-top:1px solid">
												<td style="border-right: 1px solid;">
													<h3 style="margin-left:2ex">
																7.Pounds/Gal or Bulk Density
													</h3>
													<div style="background-color: #E8E8E8;padding-left:20px">
														<xsl:value-of select="v3:component/v3:structuredBody/v3:component/v3:section/v3:subject/v3:manufacturedProduct/v3:subjectOf/v3:characteristic[v3:code/@code = 'PC00-1']/v3:value/@unit"/>
													</div>
												</td>
												<td style="border-right: 1px solid;">
													<h3 style="margin-left:2ex">
																8.pH
													</h3>
													<div style="background-color: #E8E8E8;padding-left:20px">
														<xsl:value-of select="v3:component/v3:structuredBody/v3:component/v3:section/v3:subject/v3:manufacturedProduct/v3:subjectOf/v3:characteristic[v3:code/@code = 'PC00-2']/v3:value/@value"/>
													</div>
												</td>
												<td>
													<h3 style="margin-left:2ex">
																9.Flash Point/Flame Extension
													</h3>
													<div style="background-color: #E8E8E8;padding-left:20px">
														<xsl:value-of select="v3:component/v3:structuredBody/v3:component/v3:section/v3:subject/v3:manufacturedProduct/v3:subjectOf/v3:characteristic[v3:code/@code = 'PC00-4']/v3:value/@unit"/>
													</div>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<table cellpadding="0" class="tableContentAlign3911" style="width:1300px;margin-top: 0ex;margin-bottom:0ex;">
								<tr style="border-top:1px solid">
									<td style="border-right: 1px solid;width:9%">EPA USE ONLY</td>
									<td style="border-right: 1px solid;width:16%">10. Components in Formulation</td>
									<td style="border-right: 1px solid;width:16%">11. Supplier Name and Address</td>
									<td style="border-right: 1px solid;width:10%">12. EPA reg. No</td>
									<td style="border-right: 1px solid;" colspan="2">13. Each Component in formulation</td>
									<td style="border-right: 1px solid;" colspan="2">14. Certified Limits % by Weight</td>
									<td style="width:15%">15. Purpose in Formulation</td>
								</tr>
								<tr style="border-bottom:1px solid">
									<td style="border-right: 1px solid;"></td>
									<td style="border-right: 1px solid;"></td>
									<td style="border-right: 1px solid;"></td>
									<td style="border-right: 1px solid;"></td>
									<td style="text-align:center">Amount</td>
									<td style="border-right: 1px solid;text-align:center">% by weight</td>
									<td style="text-align:center">Upper limit</td>
									<td style="border-right: 1px solid;text-align:center">Lower limit</td>
									<td></td>
								</tr>
								<xsl:apply-templates mode="Indexing_Table" select="v3:component/v3:structuredBody/v3:component/v3:section/v3:subject/v3:manufacturedProduct/v3:manufacturedProduct/v3:ingredient"/>
								<tr style="border-top:1px solid;">
									<td colspan="2">
									16. Typed Name of Approving Official
									</td>
									<td colspan="2" style="background-color: #E8E8E8;border-right:1px solid">
										<xsl:value-of select="v3:author/v3:assignedEntity/v3:assignedPerson/v3:name"/>
									</td>
									<td colspan="1" style="border-right:1px solid;border-bottom:1px">
									17. Total Weight
										<div style="background-color: #E8E8E8;padding-left:20px;border-bottom:0px">
											<xsl:value-of select="v3:component/v3:structuredBody/v3:component/v3:section/v3:subject/v3:manufacturedProduct/v3:manufacturedProduct/v3:ingredient/v3:quantity/v3:denominator/@value"/><xsl:value-of select="v3:component/v3:structuredBody/v3:component/v3:section/v3:subject/v3:manufacturedProduct/v3:manufacturedProduct/v3:ingredient/v3:quantity/v3:denominator/@unit"/>
										</div>
									</td>
									<td colspan="1" style="border-right:1px solid;background-color: #E8E8E8">
									100%
									</td>
								</tr>
								<tr style="border-top:1px solid;">
									<td colspan="2" style="border-right:1px solid">
									18. Signature of Approving Official
									</td>
									<td colspan="1">
									19. Title
									</td>
									<td colspan="2" style="border-right:1px solid;background-color: #E8E8E8">
									</td>
									<td colspan="3" style="border-right:1px solid">
									20.Phone No.(Include Area Code)
									</td>
									<td colspan="1">
									21. Date
										<div style="background-color: #E8E8E8;padding-left:20px">
											<xsl:value-of select="v3:author/v3:time/@value"/>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>	
	<xsl:template mode="Indexing_Table" match="v3:ingredient">
			<tr style="border-bottom:1px solid">
				<td style="border-right: 1px solid;background-color: #E8E8E8;text-align:center">	
				</td>
				<td style="border-right: 1px solid;background-color: #E8E8E8;text-align:center">
					<xsl:value-of select="v3:ingredientSubstance/v3:name"/>
				</td>
				<td colspan="2" style="border-right: 1px solid;background-color: #E8E8E8;">
					<table style="width:100%;margin-top:0ex;margin-bottom:0ex" class="s t r">
						<xsl:for-each select="v3:subjectOf">
							<xsl:apply-templates mode="addr" select="v3:substanceSpecification"/>
						</xsl:for-each>
					</table>
				</td>
				<!-- <td style="border-right: 1px solid;background-color: #E8E8E8;">
					<table style="width:100%;margin-top:0ex;margin-bottom:0ex" height="184">
						<xsl:for-each select="v3:subjectOf">
							<xsl:apply-templates mode="no" select="v3:substanceSpecification"/>
						</xsl:for-each>
					</table>
				</td> -->
				<td style="border-right: 1px solid;background-color: #E8E8E8;text-align:center">
					<xsl:value-of select="v3:quantity/v3:numerator/@value"/><xsl:value-of select="../v3:quantity/v3:numerator/@unit"/>
				</td>
				<td style="border-right: 1px solid;background-color: #E8E8E8;text-align:center">
					<xsl:value-of select="v3:quantity/@value"/>
				</td>
				<td style="border-right: 1px solid;background-color: #E8E8E8;text-align:center">
				</td>
				<td style="border-right: 1px solid;background-color: #E8E8E8;text-align:center">
				</td>
				<td style="background-color: #E8E8E8;text-align:center">
					<xsl:value-of select="@classCode"/>
				</td>
			</tr>
	</xsl:template>
	<xsl:template mode="Name_Address" match="v3:contactParty">
		<xsl:text>Name : </xsl:text><xsl:value-of select="v3:contactPerson/v3:name"/><br/>
		<xsl:text>Address : - </xsl:text><br/>
		<xsl:text>Street : </xsl:text><xsl:value-of select="v3:addr/v3:streetAddressLine"/><br/>
		<xsl:text>city : </xsl:text><xsl:value-of select="v3:addr/v3:city"/><br/>
		<xsl:text>State : </xsl:text><xsl:value-of select="v3:addr/v3:state"/><br/>
		<xsl:text>Posatal Code : </xsl:text><xsl:value-of select="v3:addr/v3:postalCode"/><br/>
		<xsl:text>Country : </xsl:text><xsl:value-of select="v3:addr/v3:country"/><br/>		
	<!-- 	<xsl:text>Telephone : </xsl:text><xsl:value-of select="v3:telecom[1]/@value"/><br/>
		<xsl:text>Email : </xsl:text><xsl:value-of select="v3:telecom[2]/@value"/><br/> -->
	</xsl:template>	
	<xsl:template mode="addr" match="v3:substanceSpecification">
		<tr>
			<td style="border-right:1px solid;width:61.7%">
				<xsl:variable name="ingre" select="v3:code/@code"/>
				<xsl:apply-templates mode="Name_Address" select="../../../../../../../../../../v3:author/v3:assignedEntity/v3:representedOrganization/v3:assignedEntity/v3:assignedOrganization/v3:assignedEntity/v3:assignedOrganization[v3:id[@root='1.9.99.999.9999']/@extension = $ingre]/v3:contactParty"/>
			</td>
			<td style="text-align:center;width:38.3%">
				<xsl:variable name="a" select="v3:code/@code"/>
				<xsl:value-of select="$a"/>
			</td>
		</tr>
	</xsl:template>
</xsl:transform>