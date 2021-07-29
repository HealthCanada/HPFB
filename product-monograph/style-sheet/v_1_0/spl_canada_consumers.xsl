<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns="urn:hl7-org:v3" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:str="http://exslt.org/strings" 
	xmlns:v3="urn:hl7-org:v3"
	exclude-result-prefixes="v3 xsl">
	<xsl:import href="spl_canada.xsl"/>

	<xsl:param name="css">https://healthcanada.github.io/HPFB/product-monograph/style-sheet/spl_canada.css</xsl:param>
	<xsl:param name="alt-lang-docid">alternate-language-document</xsl:param>
	
	<xsl:template match="v3:document" mode="html-head">
		<head>
			<meta charset="utf-8"/>
			<meta name="viewport" content="width=device-width, initial-scale=1"/>
			<!-- [pmh] remove superfluous charset and language meta information
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>  
			<meta http-equiv="Content-Language" content="{ $lang }-ca"/>
			<meta http-equiv="X-UA-Compatible" content="IE=10"/> -->
			<meta name="documentId">
				<xsl:attribute name="content"><xsl:value-of select="v3:id/@root"/></xsl:attribute>
			</meta>
			<meta name="documentSetId">
				<xsl:attribute name="content"><xsl:value-of select="v3:setId/@root"/></xsl:attribute>
			</meta>
			<meta name="documentVersionNumber">
				<xsl:attribute name="content"><xsl:value-of select="v3:versionNumber/@value"/></xsl:attribute>
			</meta>
			<meta name="documentEffectiveTime">
				<xsl:attribute name="content"><xsl:value-of select="v3:effectiveTime/@value"/></xsl:attribute>
			</meta>
			<title><xsl:value-of select="$doc-title"/></title>
			<link media="screen" rel="stylesheet" href="http://canada.ca/etc/designs/canada/wet-boew/css/wet-boew.min.css"><xsl:text> </xsl:text></link>
			<link media="screen" rel="stylesheet" href="http://canada.ca/etc/designs/canada/wet-boew/css/theme.min.css"><xsl:text> </xsl:text></link>
			<link href="http://canada.ca/etc/designs/canada/wet-boew/assets/favicon.ico" rel="icon" type="image/x-icon"><xsl:text> </xsl:text></link>
			<link rel="stylesheet" href="{$css}"><xsl:text> </xsl:text></link>
			<style>
				
				@media screen {
					.spl {
						line-height: 1.5;
					}
					.list-unstyled .spl {
						padding-bottom: 0px;
						margin-left: 0px;
						margin-right: 0px;
					}
				}
				
				<!-- this french language reduction reduces only the top level navigation -->
				<xsl:if test="$lang='fr'">#side .nav-top { font-size: 75%; }</xsl:if>				
			</style>
		</head>
	</xsl:template>	
	
	<!-- MAIN HTML PAGE TEMPLATING -->
	<xsl:template match="/v3:document" priority="1">
		<!-- [pmh] added lang to consumer information view html5 style -->
		<html lang="{ $lang }-ca">
			<xsl:apply-templates select="." mode="html-head"/>
			<body>
				<xsl:call-template name="canada-screen-body-header"/>
				<div class="container">
					<div class="row">
						<!--<main property="mainContentOfPage" class="col-md-9 col-md-push-3">-->
						<!-- with section menu -->
						<main property="mainContentOfPage" class="container">
<!--							<h1 id="wb-cont" class="wb-cont">Details for: <strong><xsl:value-of select="v3:title"/></strong></h1> -->
							<h2 class="wb-cont">
								Company: <xsl:value-of select="v3:author/v3:assignedEntity/v3:representedOrganization/v3:name"/>
							</h2>
							<table class="table table-hover table-bordered table-responsive">
								<xsl:call-template name="din-table-header"/>
								<tbody>
									<xsl:apply-templates select="//v3:subject/v3:manufacturedProduct" mode="dins"/>
								</tbody>
							</table> 
						<!--	<span class="" style="margin:5px 0px 0px 15px;"><a href="https://www.canada.ca/en/health-canada/services/drugs-health-products/medeffect-canada/adverse-reaction-database.html">Search Reported Side Effects</a></span><span class="" style="display:block;margin:10px 0px 0px 15px;" >
								<a href="static/content/form-formule.php?lang=en">Report a Side Effect</a></span><div class="clear" style="clear:both;"></div><h3>Summary Reports</h3><div class="" style="margin:5px 0px 0px 15px;"><a href="/reg-content/summary-basis-decision-detailOne.php?linkID=SBD00009">Summary Basis of Decision</a><br/></div>
							<div class="clear" style="clear:both;"></div> -->
							<hr/><h3>Consumer Information</h3><p>The following Consumer Information is available in the Drug and Health Product Register.</p><!-- SUB-HEADER START | DEBUT DU SOUS EN-TETE -->
								<xsl:for-each select="//v3:component/v3:section[v3:code/@code='pmi00']">
								<ul class="list-unstyled">
									<xsl:for-each select="v3:component/v3:section">
										<li>
											<details>
												<summary><xsl:value-of select="v3:title"/></summary>
												<div class="spl">
													<xsl:apply-templates select="v3:text"/>
												</div>
											</details>
										</li>								
									</xsl:for-each>
								</ul>
							</xsl:for-each>												
						</main>
					</div>
				</div>
				<xsl:call-template name="canada-screen-body-footer"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="din-table-header">
		<thead>
			<tr>
				<th  rowspan="1" colspan="1" id="din">DIN</th>
				<th  rowspan="1" colspan="1" id="product"><xsl:value-of select="$labels/product[@lang = $lang]"/></th>
				<th  rowspan="1" colspan="1" id="active"><xsl:value-of select="$labels/activeIngredients[@lang = $lang]"/></th>
				<th  rowspan="1" colspan="1" id="strength"><xsl:value-of select="$labels/strength[@lang = $lang]"/></th>
				<th  rowspan="1" colspan="1" id="form"><xsl:value-of select="$labels/dosageForm[@lang = $lang]"/></th>
				<th  rowspan="1" colspan="1" id="route"><xsl:value-of select="$labels/adminRoute[@lang = $lang]"/></th>
			</tr>
		</thead>
	</xsl:template>

	<xsl:template match="v3:subject/v3:manufacturedProduct" mode="dins">
		<tr>
			<td headers="din"><xsl:value-of select="v3:manufacturedProduct/v3:code/@code"/></td>
			<td headers="product"><xsl:value-of select="v3:manufacturedProduct/v3:name"/></td>
			<td headers="active">
				<xsl:for-each select="v3:manufacturedProduct//v3:ingredient[not(@classCode='IACT')]">
					<div><xsl:value-of select="v3:ingredientSubstance/v3:name"/></div>
				</xsl:for-each>	
			</td>
			<td headers="strength">
				<xsl:for-each select="v3:manufacturedProduct//v3:ingredient[not(@classCode='IACT')]">
					<div><xsl:apply-templates select="v3:quantity/v3:numerator"/></div>
				</xsl:for-each>													
			</td>
			<td headers="form"><xsl:value-of select="v3:manufacturedProduct//v3:formCode/@displayName"/></td>
			<td headers="route"><xsl:value-of select="v3:consumedIn/v3:substanceAdministration/v3:routeCode/@displayName"/></td>
		</tr>		
	</xsl:template>

	<xsl:template name="canada-screen-body-header">
		<!-- Skip to Main etc -->
		<nav>
			<ul id="wb-tphp">
				<li class="wb-slc">
					<a class="wb-sl" href="#wb-cont"><xsl:value-of select="$labels/skipToMainContent[@lang = $lang]"/></a>
				</li>
				<li class="wb-slc">
					<a class="wb-sl" href="#wb-info">Skip to "About government"</a>
				</li>
			</ul>
		</nav>
		
		<!-- Language Selection etc -->
		<header>
			<div class="container" id="wb-bnr">
				<div class="row">
					<section class="col-xs-3 col-sm-12 pull-right text-right" id="wb-lng">
						<h2 class="wb-inv">Language selection</h2>
						<ul class="list-inline mrgn-bttm-0">
							<li>
								<xsl:choose>
									<xsl:when test="$lang='en'">
										<a href="{$alt-lang-docid}.html" hreflang="fr" lang="fr">
											<span class="hidden-xs">Français</span>
											<abbr class="visible-xs h3 mrgn-tp-sm mrgn-bttm-0 text-uppercase" title="Français">fr</abbr>											
										</a>
									</xsl:when>
									<xsl:when test="$lang='fr'">
										<a href="{$alt-lang-docid}.html" hreflang="en" lang="en">
											<span class="hidden-xs">English</span>
											<abbr class="visible-xs h3 mrgn-tp-sm mrgn-bttm-0 text-uppercase" title="English">en</abbr>
										</a>
									</xsl:when>
								</xsl:choose>
							</li>
						</ul>
					</section>
					
					<!-- Government of Canada - note fixed relative links -->
					<div class="brand col-xs-9 col-sm-5 col-md-4" property="publisher" resource="#wb-publisher" typeof="GovernmentOrganization">
						<a href="https://www.canada.ca/en.html" property="url"><img alt="Government of Canada" property="logo" src="https://wet-boew.github.io/themes-dist/GCWeb/GCWeb/assets/sig-blk-en.svg" /><span class="wb-inv"> / <span lang="fr">Gouvernement du Canada</span></span></a>
						<meta content="Government of Canada" property="name"/>
						<meta content="Canada" property="areaServed" typeof="Country"/>
						<link href="https://wet-boew.github.io/themes-dist/GCWeb/GCWeb/assets/wmms-blk.svg" property="logo"/>
					</div>
					
					<!-- Search etc -->
					<section id="wb-srch" class="col-lg-offset-4 col-md-offset-4 col-sm-offset-2 col-xs-12 col-sm-5 col-md-4">
						<h2>Search</h2>
						<form action="#" method="post" name="cse-search-box" role="search">
							<div class="form-group wb-srch-qry">
								<label for="wb-srch-q" class="wb-inv">Search Canada.ca</label>
								<input id="wb-srch-q" list="wb-srch-q-ac" class="wb-srch-q form-control" name="q" type="search" value="" size="34" maxlength="170" placeholder="Search Canada.ca"/>
								<datalist id="wb-srch-q-ac">
								</datalist>
							</div>
							<div class="form-group submit">
								<button type="submit" id="wb-srch-sub" class="btn btn-primary btn-small" name="wb-srch-sub"><span class="glyphicon-search glyphicon"></span><span class="wb-inv">Search</span></button>
							</div>
						</form>
					</section>
				</div>
			</div>
			
			<!-- Navigation and Breadcrumb -->
			<nav class="gcweb-menu" typeof="SiteNavigationElement">
				<div class="container">
					<h2 class="wb-inv">Menu</h2>
					<button type="button" aria-haspopup="true" aria-expanded="false"><span class="wb-inv">Main </span>Menu <span class="expicon glyphicon glyphicon-chevron-down"></span></button>
					<ul role="menu" aria-orientation="vertical" data-ajax-replace="https://www.canada.ca/content/dam/canada/sitemenu/sitemenu-v2-en.html">
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/jobs.html">Jobs and the workplace</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/immigration-citizenship.html">Immigration and citizenship</a></li>
						<li role="presentation"><a role="menuitem" href="https://travel.gc.ca/">Travel and tourism</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/business.html">Business and industry</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/benefits.html">Benefits</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/health.html">Health</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/taxes.html">Taxes</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/environment.html">Environment and natural resources</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/defence.html">National security and defence</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/culture.html">Culture, history and sport</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/policing.html">Policing, justice and emergencies</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/transport.html">Transport and infrastructure</a></li>
						<li role="presentation"><a role="menuitem" href="https://international.gc.ca/world-monde/index.aspx?lang=eng">Canada and the world</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/finance.html">Money and finances</a></li>
						<li role="presentation"><a role="menuitem" href="https://www.canada.ca/en/services/science.html">Science and innovation</a></li>
					</ul>
				</div>
			</nav>
			<nav id="wb-bc" property="breadcrumb">
				<h2>You are here:</h2>
				<div class="container">
					<ol class="breadcrumb">
						<li><a href="https://www.canada.ca/en.html">Canada.ca</a></li>
						<li><a href="https://www.canada.ca/en.html">Drugs and Health Products</a></li>
<!--						<li><a href="https://www.canada.ca/en.html"><xsl:copy-of select="v3:title/node()"/></a></li> -->
					</ol>
				</div>
			</nav>
		</header>
		
		<header class="bg-aurora-accent2 hide-in-print my-4" id="banner">
			<div class="container py-4">
				<div class="text-white font-weight-bold">Drug and Health Products Register</div>
			</div>
			<div class="bg-aurora-accent1 hide-in-print mb-2">
				<div class="container py-2">
					<div class="text-white font-weight-bold"><xsl:copy-of select="v3:title/node()"/></div>
				</div>
			</div>
		</header>		
	</xsl:template>
	
	<xsl:template name="canada-screen-body-footer">
		<footer id="wb-info">
			<div class="landscape">
				<nav class="container wb-navcurr">
					<h2 class="wb-inv">About government</h2>
					<ul class="list-unstyled colcount-sm-2 colcount-md-3">
						<li><a href="https://www.canada.ca/en/health-canada/corporate/contact-us.html">Contact us</a></li>
						<li><a href="https://www.canada.ca/en/government/dept.html">Departments and agencies</a></li>
						<li><a href="https://www.canada.ca/en/government/publicservice.html">Public service and military</a></li>
						<li><a href="https://www.canada.ca/en/news.html">News</a></li>
						<li><a href="https://www.canada.ca/en/government/system/laws.html">Treaties, laws and regulations</a></li>
						<li><a href="https://www.canada.ca/en/transparency/reporting.html">Government-wide reporting</a></li>
						<li><a href="http://pm.gc.ca/en">Prime Minister</a></li>
						<li><a href="https://www.canada.ca/en/government/system.html">About government</a></li>
						<li><a href="http://open.canada.ca/en">Open government</a></li>
					</ul>
				</nav>
			</div>
			<div class="brand">
				<div class="container">
					<div class="row">
						<nav class="col-md-10 ftr-urlt-lnk">
							<h2 class="wb-inv">About this site</h2>
							<ul>
								<li><a href="https://www.canada.ca/en/social.html">Social media</a></li>
								<li><a href="https://www.canada.ca/en/mobile.html">Mobile applications</a></li>
								<li><a href="https://www.canada.ca/en/government/about.html">About Canada.ca</a></li>
								<li><a href="https://www.canada.ca/en/transparency/terms.html">Terms and conditions</a></li>
								<li><a href="https://www.canada.ca/en/transparency/privacy.html">Privacy</a></li>
							</ul>
						</nav>
						<div class="col-xs-6 visible-sm visible-xs tofpg">
							<a href="#wb-cont">Top of page <span class="glyphicon glyphicon-chevron-up"></span></a>
						</div>
						<div class="col-xs-6 col-md-2 text-right">
							<img src="https://wet-boew.github.io/themes-dist/GCWeb/GCWeb/assets/wmms-blk.svg" alt="Symbol of the Government of Canada"/>
						</div>
					</div>
				</div>
			</div>
		</footer>
		<xsl:call-template name="canada-screen-body-scripts"/> 
	</xsl:template>
	
</xsl:transform>