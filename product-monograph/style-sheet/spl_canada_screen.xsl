<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:v3="urn:hl7-org:v3" xmlns:str="http://exslt.org/strings" 
	xmlns:exsl="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" 
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="exsl msxsl v3 gc xsl xsi str">

	<!-- accordion card for company details and distributor details - note the spl class that triggers FDA styles -->
	<xsl:template mode="screen" match="//v3:author/v3:assignedEntity/v3:representedOrganization">
		<section class="card m-2" id="company-details">
			<a name="company-details"> </a>
			<!-- [pmh] replaced h6 with div and strong -->
			<header class="card-header p-0 bg-aurora-light font-weight-bold">
				<button class="btn bg-aurora-light text-left w-100" type="button" 
				data-toggle="collapse" data-target="#collapse-company-details" 
				aria-expanded="true" aria-controls="collapse-company-details">
					<xsl:value-of select="$labels/companyDetails[@lang = $lang]"/>						
				</button>
			</header>
			<div id="collapse-company-details" class="collapse show spl" data-parent="#product-accordion">
				<xsl:apply-templates mode="subjects" select="."/>
				<xsl:apply-templates mode="subjects" select="v3:assignedEntity/v3:assignedOrganization"/>
			</div>
		</section>
	</xsl:template>
	
	<!-- accordion card for product details - note the spl class that triggers FDA styles -->
	<xsl:template mode="screen" match="v3:subject/v3:manufacturedProduct">
		<xsl:variable name="unique-product-id">product-<xsl:value-of select="position()"/></xsl:variable>
		<section class="card m-2" id="{$unique-product-id}">
			<!-- [pmh] replaced h6 with div and strong -->
			<header class="card-header p-0 bg-aurora-light font-weight-bold">
				<button class="btn bg-aurora-light text-left w-100" type="button" 
				data-toggle="collapse" data-target="#collapse-{$unique-product-id}" 
				aria-expanded="true" aria-controls="collapse-{$unique-product-id}">
					<xsl:apply-templates select="v3:manufacturedProduct" mode="generateUniqueLabel">
						<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
					</xsl:apply-templates>						
				</button>
			</header>
			<div id="collapse-{$unique-product-id}" class="collapse spl" data-parent="#product-accordion">
				<xsl:apply-templates mode="subjects" select="."/>
			</div>
		</section>	
	</xsl:template>
	
	<xsl:template mode="generateUniqueLabel" match="v3:manufacturedProduct">
		<xsl:param name="position"/>
		<xsl:value-of select="$labels/product[@lang = $lang]"/> #<xsl:value-of select="$position"/><xsl:text> </xsl:text><xsl:value-of select="v3:name"/> 
		(<xsl:value-of select="v3:asEntityWithGeneric/v3:genericMedicine/v3:name"/>)<xsl:if test="not((v3:formCode/@code='C43197') and (v3:formCode/@codeSystem='2.16.840.1.113883.2.20.6.3'))">, 		
			<!-- Withhold the display name and the comma when the form code indicates that this is a 'kit' -->
			<xsl:for-each select="v3:ingredient[starts-with(@classCode,'ACTI')]">
				<xsl:if test="position() > 1">/ </xsl:if>
				<xsl:value-of select="v3:ingredientSubstance/v3:activeMoiety/v3:activeMoiety/v3:code/@displayName"/>&#160;
				<xsl:apply-templates select="v3:quantity/v3:numerator"/>&#160;
			</xsl:for-each>
			<xsl:value-of select="v3:formCode[@codeSystem='2.16.840.1.113883.2.20.6.3']/@displayName"/>
		</xsl:if>
	</xsl:template>
	
	<!-- Navigation Sidebar Menu -->
	<xsl:template match="v3:structuredBody" mode="sidebar-navigation">
		<aside class="hide-in-print mb-2" id="left">
			<div class="sticky-top sticky d-none d-md-block hide-in-print" id="side">
				<section class="card">
					<!-- [pmh] replace top level headings with semantic stuff like headers - move the font-size eventually
					<h5 class="card-header text-white bg-aurora-accent1">
						<xsl:value-of select="$labels/tableOfContents[@lang = $lang]"/>
					</h5> -->
					<header class="card-header bg-aurora-accent1 text-white font-weight-bold">
						<xsl:value-of select="$labels/tableOfContents[@lang = $lang]"/>
					</header>
					<!-- This transform positions the scrollbar to the left of the Navigation Sidebar Menu.
						 We could move these inline styles, and also apply -ms-transform and -webkit-transform -->
					<div style="transform: scaleX(-1);" id="navigation-scrollbar">
						<ul class="navbar-nav" id="navigation-sidebar" style="transform: scaleX(-1); ">
							<!-- Add table of contents boilerplate as a separate list item, with nav-top class so the French label is reduced -->
							<li class="nav-top"><xsl:value-of select="$labels/tocBoilerplate[@lang = $lang]"/></li>
							<xsl:for-each select="v3:component/v3:section">
								<xsl:variable name="unique-section-id"><xsl:value-of select="v3:id/@root"/></xsl:variable>
								<xsl:choose>
									<xsl:when test="v3:code[@code='0MP']">
										<!-- PRODUCT DETAIL NAVIGATION -->
										<li class="nav-item">
											<a href="#drop-{$unique-section-id}" class="nav-link nav-top dropdown-toggle" data-toggle="collapse">
												<xsl:value-of select="$labels/productDetails[@lang = $lang]"/>
											</a>
											<ul id="drop-{$unique-section-id}" 
											   class="navbar-nav small collapse">
												<li class="nav-item">
													<a href="#company-details" class="nav-link active">
														<xsl:value-of select="$labels/companyDetails[@lang = $lang]"/>
													</a>
												</li>
												<xsl:apply-templates select="v3:subject/v3:manufacturedProduct" mode="sidebar-navigation"/>
											</ul>
										</li>							
									</xsl:when>
									<!-- NAVIGATION FOR TITLE PAGE OR ANY OTHER SECTION WITH NO SUBSECTIONS, LIKE RECENT MAJOR LABEL CHANGE -->
									<xsl:when test="v3:code[@code='0TP'] or not(v3:component/v3:section)">
										<li class="nav-item">
											<a href="#{$unique-section-id}" class="nav-link nav-top">
												<xsl:value-of select="v3:title"/>
											</a>
										</li>
									</xsl:when>
									<xsl:otherwise>
										<!-- NAVIGATION FOR DIFFERENT PARTS THAT CONTAIN SUBSECTIONS -->
										<li class="nav-item">
											<a href="#drop-{$unique-section-id}" class="nav-link nav-top dropdown-toggle" data-toggle="collapse">
												<xsl:value-of select="v3:title"/>
											</a>
											<xsl:if test="v3:component/v3:section">
											<ul id="drop-{$unique-section-id}" class="navbar-nav small collapse">
												<xsl:apply-templates select="v3:component/v3:section" mode="sidebar-navigation"/>
											</ul>
											</xsl:if>
										</li>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</ul>
					</div>
				</section>	
			</div>			
		</aside>	
	</xsl:template>

	<xsl:template match="v3:component/v3:section" mode="sidebar-navigation">
		<xsl:variable name="unique-section-id"><xsl:value-of select="v3:id/@root"/></xsl:variable>
		<li class="nav-item">
			<a href="#{$unique-section-id}" class="nav-link">
				<!-- This conditional should never be applied to non-draft SPL documents -->
				<xsl:if test="not(normalize-space(translate(v3:title, '&#160;', ' ')))">
					<span style="color:red;">&lt;&lt;MISSING INFORMATION&gt;&gt;</span>
				</xsl:if>
				<xsl:value-of select="v3:title"/>				
			</a>
			<xsl:if test="v3:component/v3:section">
				<ul class="navbar-nav">
					<xsl:apply-templates select="v3:component/v3:section" mode="sidebar-navigation"/>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template match="v3:subject/v3:manufacturedProduct" mode="sidebar-navigation">
		<xsl:variable name="unique-product-id">product-<xsl:value-of select="position()"/></xsl:variable>
		<li class="nav-item">
			<a href="#{$unique-product-id}" class="nav-link">
				<xsl:apply-templates select="v3:manufacturedProduct" mode="generateUniqueLabel">
					<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
				</xsl:apply-templates>
			</a>
		</li>
	</xsl:template>
		

	<xsl:template match="v3:document" mode="html-head">
		<head>
			<meta charset="utf-8"/>
			<meta name="viewport" content="width=device-width, initial-scale=1"/>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>  
			<meta http-equiv="Content-Language" content="{ $lang }-ca"/>
			<meta http-equiv="X-UA-Compatible" content="IE=10"/>			
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
			<link href="http://canada.ca/etc/designs/canada/wet-boew/assets/favicon.ico" rel="icon" type="image/x-icon"><xsl:text> </xsl:text></link>
			<link media="screen" rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"><xsl:text> </xsl:text></link>
			<link media="screen" rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"><xsl:text> </xsl:text></link>
			<link rel="stylesheet" href="{$css}"><xsl:text> </xsl:text></link>
			<style>
				/* ScrollSpy, Stickiness/Affix, and French Navigation Reduction */								
				.sticky {
					position: -webkit-sticky;
					position: sticky;
					top: 0;
				}
				
				/* [pmh] Health Canada uses #284162:active/#0535d2:hover, and I am going to always underline spl links, never navigation
				/* [pmh] added for better compliance with accessibility requirements - merge into spl_canada.css */
				.spl a, #side a.nav-link { 
					color: #002D42;
				}
				.spl a:hover, #side a.nav-link:hover,
				.spl a:focus, #side a.nav-link:focus { 
					color: #0535d2;
				}
				/* [pmh] just underline all content links, including on hover and focus? */
				.spl a, .spl a:link, .spl a:visited, .spl a:active  { 
					text-decoration: underline; 
				}
				.spl a:hover, .spl a:focus {
					text-decoration: underline;
				}
				
				/* [pmh] WCAG accessibility - pop out when this gets tabbed - move to css when ready */
				a.skip-main {
					left:-999px;
					position:absolute;
					top:auto;
					width:1px;
					height:1px;
					overflow:hidden;
					z-index:-999;
				}
				a.skip-main:focus, a.skip-main:active {
					color: #fff;
					background-color:#000;
					left: auto;
					top: auto;
					width: 30%;
					height: auto;
					overflow:auto;
					margin: 10px 35%;
					padding:4px;
					border-radius: 15px;
					border:4px solid #ffc107;
					text-align:center;
					font-size:1.2em;
					z-index:999;
				}				
								
				<!-- this french language reduction reduces only the top level navigation -->
				<xsl:if test="$lang='fr'">#side .nav-top { font-size: 75%; }</xsl:if>				
			</style>
		</head>
	</xsl:template>	
	
	<xsl:template name="canada-screen-body-footer">
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"><xsl:text> </xsl:text></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"><xsl:text> </xsl:text></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"><xsl:text> </xsl:text></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stickyfill/2.0.5/stickyfill.min.js"><xsl:text> </xsl:text></script>
		<script>
			try {
			  var elements = document.querySelectorAll('.sticky');
			  Stickyfill.add(elements);
			} catch (e) {
			  console.log(e)
			}			
			
			/* jump to top of form unscrolls left and right side and then scrolls the header into view */
			$(document).ready(function(){
				$("#btnTop").on("click", function(){
					document.getElementById('content').scrollIntoView(true);
					document.getElementById('navigation-scrollbar').scrollTop=0;
					document.getElementById('header').scrollIntoView(true);
					});
			});			
			
			// Mitigate IE/Edge bug showing bullets on lists which are hidden when loading the page
			$(document).ready(function(){
				if (document.documentMode || /Edge/.test(navigator.userAgent)) {
					$('ul:hidden').each(function(){
						$(this).parent().append($(this).detach());
					});
				}				
			});			
		</script>
	</xsl:template>
	
</xsl:transform>