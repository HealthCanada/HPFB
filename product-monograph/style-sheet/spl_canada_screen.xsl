<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:v3="urn:hl7-org:v3" xmlns:str="http://exslt.org/strings" 
	xmlns:exsl="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" 
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="exsl msxsl v3 xsl xsi str">

	<!-- accordion card for company details and distributor details - note the spl class that triggers FDA styles -->
	<xsl:template match="//v3:author/v3:assignedEntity/v3:representedOrganization" mode="card">
		<section class="card m-2" id="company-details">
			<h6 class="card-header p-0 bg-aurora-light"> <!-- dropped bg-aurora-accent2 from h6 and button -->
				<!-- pmh - this is how one might make product accordions optional -->
<!--				<div class="text-white text-left d-none d-md-block p-2">
					<xsl:value-of select="$labels/companyDetails[@lang = $lang]"/>
				</div> --> <!--  dropdown-toggle below caused problems with rwd, and possibly w-100 -->
				<button class="btn bg-aurora-light text-left w-100" type="button" 
				data-toggle="collapse" data-target="#collapse-company-details" 
				aria-expanded="true" aria-controls="collapse-company-details">
					<xsl:value-of select="$labels/companyDetails[@lang = $lang]"/>
				</button>
			</h6>
			<div id="collapse-company-details" class="collapse show spl" data-parent="#product-accordion">
				<xsl:apply-templates mode="subjects" select="."/>
				<xsl:apply-templates mode="subjects" select="v3:assignedEntity/v3:assignedOrganization"/>
			</div>
		</section>
	</xsl:template>
	
	<!-- accordion card for product details - note the spl class that triggers FDA styles -->
	<xsl:template match="v3:subject/v3:manufacturedProduct" mode="card">
		<xsl:variable name="unique-product-id">product-<xsl:value-of select="position()"/></xsl:variable>
		<section class="card m-2" id="{$unique-product-id}">
			<h6 class="card-header p-0 bg-aurora-light"> <!-- dropped bg-aurora-accent2 from h6 and button -->
				<!-- dropdown-toggle below caused problems with rwd, and possibly w-100 -->
				<button class="btn bg-aurora-light text-left w-100" type="button" 
				data-toggle="collapse" data-target="#collapse-{$unique-product-id}" 
				aria-expanded="true" aria-controls="collapse-{$unique-product-id}">
					<xsl:apply-templates select="v3:manufacturedProduct" mode="generateUniqueLabel">
						<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
					</xsl:apply-templates>
				</button>
			</h6>
			<div id="collapse-{$unique-product-id}" class="collapse spl" data-parent="#product-accordion">
				<xsl:apply-templates mode="subjects" select="."/>
			</div>
		</section>	
	</xsl:template>
	
	<xsl:template mode="generateUniqueLabel" match="v3:manufacturedProduct">
		<xsl:param name="position"/>
		<xsl:value-of select="$labels/product[@lang = $lang]"/> #<xsl:value-of select="$position"/><xsl:text> </xsl:text><xsl:value-of select="v3:name"/> 
		(<xsl:value-of select="v3:asEntityWithGeneric/v3:genericMedicine/v3:name"/>), 		
		<xsl:for-each select="v3:ingredient[starts-with(@classCode,'ACTI')]">
			<xsl:if test="position() > 1">/ </xsl:if>
			<xsl:value-of select="v3:ingredientSubstance/v3:activeMoiety/v3:activeMoiety/v3:code/@displayName"/>&#160;
			<xsl:apply-templates select="v3:quantity/v3:numerator"/>&#160;
		</xsl:for-each>
		<xsl:value-of select="v3:formCode[@codeSystem='2.16.840.1.113883.2.20.6.3']/@displayName"/>
	</xsl:template>
	
	<!-- This is a fairly decent navigation sidebar menu -->
	<xsl:template match="v3:structuredBody" mode="sidebar-navigation">
		<aside class="hide-in-print mb-2" id="left">
			<div class="sticky-top sticky d-none d-md-block hide-in-print" id="side">
				<section class="card">
					<h5 class="card-header text-white bg-aurora-accent1">
						<xsl:value-of select="$labels/tableOfContents[@lang = $lang]"/>
					</h5>
					<!-- TODO move these inline styles, and also apply -ms-transform and -webkit-transform -->
					<div style="transform: scaleX(-1);" id="navigation-scrollbar">
						<ul class="navbar-nav" id="navigation-sidebar" style="transform: scaleX(-1); ">
							<xsl:for-each select="v3:component/v3:section">
								<xsl:variable name="unique-section-id"><xsl:value-of select="@ID"/></xsl:variable>
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
									<!-- TITLE PAGE OR RECENT MAJOR LABEL CHANGE NAVIGATION -->
									<xsl:when test="v3:code[@code='0TP']|v3:code[@code='1RMLC']">
										<li class="nav-item">
											<a href="#{$unique-section-id}" class="nav-link nav-top">
												<xsl:value-of select="v3:title"/>
											</a>
										</li>
									</xsl:when>
									<xsl:otherwise>
										<!-- NAVIGATION FOR DIFFERENT PARTS -->
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
		<xsl:variable name="unique-subsection-id"><xsl:value-of select="@ID"/></xsl:variable>
		<li class="nav-item">
			<a href="#{$unique-subsection-id}" class="nav-link">
				<!-- TODO this should never be applied to non-draft SPL documents -->
				<xsl:if test="not(normalize-space(v3:title))">
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
		
	<!-- SECTION MODEL AND NUMBER MODE -->
	<!-- Special mode to construct a section number. Apply to a sequence of sections on the ancestor-or-self axis. -->
	<!-- Shallow null-transform for anything but sections. -->
	<xsl:template mode="sectionNumber" match="/|@*|node()"/>
	<xsl:template mode="sectionNumber" match="v3:section">
		<xsl:value-of select="concat('.',count(parent::v3:component/preceding-sibling::v3:component[v3:section])+1)"/>
	</xsl:template>
		
	<xsl:template match="v3:section">
		<xsl:param name="sectionLevel" select="count(ancestor-or-self::v3:section)"/>
		<xsl:variable name="sectionNumberSequence">
			<xsl:apply-templates mode="sectionNumber" select="ancestor-or-self::v3:section"/>
		</xsl:variable>
		<div class="Section">
			<xsl:for-each select="v3:code">
				<xsl:attribute name="data-sectionCode"><xsl:value-of select="@code"/></xsl:attribute>
			</xsl:for-each>

			<xsl:for-each select="@ID"><!-- AURORA SPECIFIC -->
				<xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
			</xsl:for-each>

			<xsl:call-template name="styleCodeAttr">
				<xsl:with-param name="styleCode" select="@styleCode"/>
				<xsl:with-param name="additionalStyleCode" select="'Section'"/>
			</xsl:call-template>
			<xsl:for-each select="@ID">
				<a name="{.}"><xsl:text> </xsl:text></a>
			</xsl:for-each>
			<a name="section-{substring($sectionNumberSequence,2)}"><xsl:text> </xsl:text></a>
			<p/>
			<xsl:apply-templates select="v3:title">
				<xsl:with-param name="sectionLevel" select="$sectionLevel"/>
				<xsl:with-param name="sectionNumber" select="substring($sectionNumberSequence,2)"/>
			</xsl:apply-templates>
			<!-- TODO remove all of the show-data? -->
			<xsl:if test="boolean($show-data)">
				<xsl:apply-templates mode="data" select="."/>
			</xsl:if>
			<xsl:apply-templates select="@*|node()[not(self::v3:title)]"/>
			<xsl:call-template name="flushSectionTitleFootnotes"/>
		</div>
	</xsl:template>
	
	<!-- this template is only used on the Title Page to show Control Number on a single line -->
	<xsl:template match="v3:section" mode="inline-title">
		<div class="Section">
			<br/>
			<h2 style="display: inline;">
				<!-- pmh the colon in the title is supplied by the controlled vocabulary -->
				<xsl:value-of select="v3:title"/>
				<xsl:text> </xsl:text>
			</h2>
			<xsl:value-of select="v3:text/v3:paragraph"/>
		</div>
	</xsl:template>

	<xsl:template match="v3:document" mode="html-head">
		<head>
			<meta charset="utf-8"/>
			<meta name="viewport" content="width=device-width, initial-scale=1"/>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>  
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
			<title><xsl:value-of select="v3:title"/></title>
			<link href="http://canada.ca/etc/designs/canada/wet-boew/assets/favicon.ico" rel="icon" type="image/x-icon"><xsl:text> </xsl:text></link>
			<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"><xsl:text> </xsl:text></link>
			<link rel="stylesheet" href="{$css}"><xsl:text> </xsl:text></link>
			<style>
				/* ScrollSpy, Stickiness/Affix, and French Navigation Reduction */
			  
				html {
					scroll-behavior: smooth;
				}
								
				.sticky {
					position: -webkit-sticky;
					position: sticky;
					top: 0;
				}

				<!-- this french language reduction reduces only the top level navigation -->
				<xsl:if test="$lang='fr'">#side .nav-top { font-size: 75%; }</xsl:if>				
			</style>
		</head>
	</xsl:template>	
	
	<xsl:template name="canada-screen-body-footer">
		<!-- perhaps Stickyfill should have cross origin integrity? 4.1.3 is the current "Aurora" version of Bootstrap, and I have upgraded to the latest, 4.4.1 -->
		<xsl:text disable-output-escaping="yes">
&lt;script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"&gt;&lt;/script&gt;
&lt;script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"&gt;&lt;/script&gt;
&lt;script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"&gt;&lt;/script&gt;
&lt;script src="https://cdnjs.cloudflare.com/ajax/libs/stickyfill/2.0.5/stickyfill.min.js"&gt;&lt;/script&gt;
		</xsl:text>
		<script>
			try {
			  var elements = document.querySelectorAll('.sticky');
			  Stickyfill.add(elements);
			} catch (e) {
			  console.log(e)
			}
			
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