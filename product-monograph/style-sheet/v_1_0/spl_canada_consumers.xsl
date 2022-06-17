<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:str="http://exslt.org/strings" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v3="urn:hl7-org:v3" version="1.0" exclude-result-prefixes="v3 xsl">
	<xsl:import href="spl_canada.xsl"/>
	
	<!-- MAIN HTML PAGE TEMPLATING -->
	<xsl:template match="/v3:document" priority="1">
		<main property="mainContentOfPage" class="container">
			<h2 class="wb-cont">
				<xsl:value-of select="$labels/company[@lang = $lang]"/>: <xsl:value-of select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:name"/>
			</h2>
			<table class="table table-hover table-bordered table-responsive">
				<xsl:call-template name="din-table-header"/>
				<tbody>
					<xsl:apply-templates select="//v3:subject/v3:manufacturedProduct" mode="dins"/>
				</tbody>
			</table> 
			
			<!-- <hr/>
				<a href="http://192.168.1.76/exist/apps/dhpr-spl/view-product-monograph.html?doc={ v3:id/@root }">Product Monograph</a>
				<span class="" style="margin:5px 0px 0px 15px;"><a href="https://www.canada.ca/en/health-canada/services/drugs-health-products/medeffect-canada/adverse-reaction-database.html">Search Reported Side Effects</a></span><span class="" style="display:block;margin:10px 0px 0px 15px;" >
				<a href="static/content/form-formule.php?lang=en">Report a Side Effect</a></span><div class="clear" style="clear:both;"></div><h3>Summary Reports</h3><div class="" style="margin:5px 0px 0px 15px;"><a href="/reg-content/summary-basis-decision-detailOne.php?linkID=SBD00009">Summary Basis of Decision</a><br/></div>
			<div class="clear" style="clear:both;"</div>
			<hr/> -->
			
			<h3><xsl:value-of select="$labels/patientMedicationInformation[@lang = $lang]"/></h3>
			<p>
				<xsl:value-of select="$labels/consumerBoilerplate[@lang = $lang]"/>
			</p><!-- SUB-HEADER START | DEBUT DU SOUS EN-TETE -->
			<xsl:for-each select="//v3:component/v3:section[v3:code/@code='pmi00']">
				<ul class="list-unstyled">
					<xsl:for-each select="v3:component/v3:section">
						<li>
							<details>
								<summary>
									<xsl:value-of select="v3:title"/>
								</summary>
								<div class="spl">
									<xsl:apply-templates select="v3:text"/>
								</div>
							</details>
						</li>								
					</xsl:for-each>
				</ul>
			</xsl:for-each>												
		</main>
	</xsl:template>
	
	<xsl:template name="din-table-header">
		<thead>
			<tr>
				<th rowspan="1" colspan="1" id="din">DIN</th>
				<th rowspan="1" colspan="1" id="product">
					<xsl:value-of select="$labels/product[@lang = $lang]"/>
				</th>
				<th rowspan="1" colspan="1" id="active">
					<xsl:value-of select="$labels/activeIngredients[@lang = $lang]"/>
				</th>
				<th rowspan="1" colspan="1" id="strength">
					<xsl:value-of select="$labels/strength[@lang = $lang]"/>
				</th>
				<th rowspan="1" colspan="1" id="form">
					<xsl:value-of select="$labels/dosageForm[@lang = $lang]"/>
				</th>
				<th rowspan="1" colspan="1" id="route">
					<xsl:value-of select="$labels/adminRoute[@lang = $lang]"/>
				</th>
			</tr>
		</thead>
	</xsl:template>
	
	<xsl:template match="v3:subject/v3:manufacturedProduct" mode="dins">
		<tr>
			<td headers="din">
				<xsl:value-of select="v3:manufacturedProduct/v3:code/@code"/>
			</td>
			<td headers="product">
				<xsl:value-of select="v3:manufacturedProduct/v3:name"/>
			</td>
			<td headers="active">
				<xsl:for-each select="v3:manufacturedProduct//v3:ingredient[not(@classCode='IACT')]">
					<div>
						<xsl:value-of select="v3:ingredientSubstance/v3:name"/>
					</div>
				</xsl:for-each>	
			</td>
			<td headers="strength">
				<xsl:for-each select="v3:manufacturedProduct//v3:ingredient[not(@classCode='IACT')]">
					<div>
						<xsl:apply-templates select="v3:quantity/v3:numerator"/>
					</div>
				</xsl:for-each>													
			</td>
			<td headers="form">
				<xsl:value-of select="v3:manufacturedProduct//v3:formCode/@displayName"/>
			</td>
			<td headers="route">
				<xsl:value-of select="v3:consumedIn/v3:substanceAdministration/v3:routeCode/@displayName"/>
			</td>
		</tr>		
	</xsl:template>
	
</xsl:transform>