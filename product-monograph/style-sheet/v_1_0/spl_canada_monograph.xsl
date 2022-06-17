<xsl:transform xmlns:str="http://exslt.org/strings" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:v3="urn:hl7-org:v3" version="1.0" exclude-result-prefixes="v3 xsl">
    <xsl:import href="spl_canada.xsl"/>
    
    <!-- MAIN HTML PAGE TEMPLATING -->
    <xsl:template match="/v3:document" priority="1">
        <main property="mainContentOfPage" class="container-fluid">
            <style>
                /* ScrollSpy, Stickiness/Affix, and French Navigation Reduction */								
                .sticky {
                position: -webkit-sticky;
                position: sticky;
                top: 0;
                }				
                
                <!-- this french language reduction reduces only the top level navigation -->
                <xsl:if test="$lang='fr'">#side .nav-top { font-size: 80%; }</xsl:if>				
            </style>
            <div class="row h-100">
                <xsl:apply-templates select="v3:component/v3:structuredBody" mode="sidebar-navigation"/>
                <xsl:apply-templates select="v3:component/v3:structuredBody" mode="main-document"/>
            </div>					
        </main>
    </xsl:template>
    
    <!-- Main page content, which renders for both screen -->	
    <xsl:template mode="main-document" match="v3:structuredBody">
        <main class="col">
            <div class="container-fluid" id="main">
                <div class="row position-relative" id="wb-cont">
                    <div class="col">
                        <xsl:for-each select="v3:component/v3:section[not(v3:code/@code='0MP')]">
                            <xsl:variable name="unique-section-id">
                                <xsl:value-of select="v3:id/@root"/>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="v3:code[@code='0TP']">
                                    <!-- TITLE PAGE - Note: force-page-break-after here does not work on FireFox -->
                                    <div class="card mb-2 force-page-break-after" id="{$unique-section-id}">
                                        <header class="card-header bg-aurora-accent1 text-white font-weight-bold hide-in-print">
                                            <xsl:value-of select="v3:title"/>
                                        </header>
                                        
                                        <!-- Extra hidden Title Page heading for semantic accessibility purposes -->
                                        <h1 class="hide-in-screen hide-offscreen"><xsl:value-of select="v3:title"/></h1>
                                        <div class="spl title-page title-page-row">
                                            <xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.1']/v3:text"/>
                                        </div>
                                        <div class="spl title-page-row title-page-rule-top">
                                            <div class="title-page-left">
                                                <xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.2']/v3:text"/>
                                                <xsl:if test="count(v3:component/v3:section[v3:code/@code='0tp1.2']/v3:text/v3:paragraph)=1">
                                                    <br/><br/><br/><br/>
                                                </xsl:if>
                                            </div>
                                            <div class="title-page-right">
                                                <xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.3']" mode="international-date-format"/>
                                                <xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.4']" mode="international-date-format"/>
                                                <xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.5']"/>
                                            </div>
                                        </div>											
                                        <div class="spl title-page title-page-row">
                                            <xsl:apply-templates select="v3:component/v3:section[v3:code/@code='0tp1.6']/v3:text"/>
                                        </div>
                                    </div>
                                </xsl:when>
                                <xsl:when test="v3:code[@code='0NOC']">
                                    <!-- Optional NOTICE OF COMPLIANCE WITH CONDITIONS section does not require page break -->
                                    <xsl:apply-templates mode="main-document" select="."/>									
                                </xsl:when>
                                <xsl:when test="v3:code[@code='1RMLC']">
                                    <!-- RECENT MAJOR LABEL CHANGES - These require extra styling to suppress table rules -->
                                    <div class="card mb-2" id="{$unique-section-id}">
                                        <header class="card-header bg-aurora-accent1 text-white font-weight-bold">
                                            <xsl:value-of select="v3:title"/>
                                        </header>
                                        <div class="spl recent-changes">
                                            <xsl:apply-templates select="."/>
                                        </div>
                                    </div>
                                </xsl:when>
                                <!-- Withhold the optional Biosimilar Biologic Drug and prepend to Part I after TOC -->
                                <xsl:when test="v3:code[@code='0BBD']"/>									
                                <xsl:when test="v3:code[@code='pi00']">
                                    <!-- TABLE OF CONTENTS IMMEDIATELY PRECEDES PART I IN PRINT VERSION - WITHHOLD ACTUAL TOC FOR NOW -->
                                    <xsl:choose>
                                        <xsl:when test="$show-print-toc">
                                            <xsl:call-template name="render-toc"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <div class="hide-in-screen force-page-break-after"><!-- This is where the TOC would be --></div>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <!-- Optional BIOSIMILAR BIOLOGIC DRUG, prepended to Part I if present -->
                                    <xsl:apply-templates mode="main-document" select="../../v3:component/v3:section[v3:code/@code='0BBD']"/>
                                    <!-- PART I HEALTH PROFESSIONAL INFORMATION requires page break after -->								
                                    <xsl:apply-templates mode="main-document" select=".">
                                        <xsl:with-param name="additional-classes">force-page-break-after</xsl:with-param>
                                    </xsl:apply-templates>									
                                </xsl:when>
                                <xsl:otherwise>
                                    <!-- ADDITIONAL SECTIONS - PART II and optional sections like PMI, etc -->
                                    <xsl:apply-templates mode="main-document" select=".">
                                        <xsl:with-param name="additional-classes">force-page-break-after</xsl:with-param>									
                                    </xsl:apply-templates>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        <!-- SCREEN VERSION OF MANUFACTURED PRODUCT DETAIL -->
                        <xsl:for-each select="v3:component/v3:section[v3:code/@code='0MP']">
                            <xsl:variable name="unique-section-id">
                                <xsl:value-of select="v3:id/@root"/>
                            </xsl:variable>
                            <div class="card mb-2 hide-in-print" id="{$unique-section-id}">
                                <header class="card-header bg-aurora-accent1 text-white font-weight-bold">
                                    <xsl:value-of select="$labels/productDetails[@lang = $lang]"/>
                                </header>
                                <!-- Company Details and Product Details Accordion Cards -->
                                <div id="product-accordion">
                                    <ul class="list-unstyled">
                                        <xsl:apply-templates mode="screen" select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization"/>
                                        <xsl:apply-templates mode="screen" select="v3:subject/v3:manufacturedProduct"/>
                                    </ul>
                                </div>
                            </div>
                        </xsl:for-each>
                        <!-- SCREEN VERSION OF EXTRA SECTION FOR REVIEW ONLY -->
                        <!-- PRINT VERSION OF MANUFACTURED PRODUCT DETAIL will already have a page break after previous section -->
                        <div class="hide-in-screen card spl" id="print-product-details">
                            <h1>
                                <xsl:call-template name="string-uppercase">
                                    <xsl:with-param name="text">
                                        <xsl:value-of select="$labels/productDetails[@lang = $lang]"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </h1>
                            <div class="spl">
                                <xsl:apply-templates mode="print" select="/v3:document/v3:author/v3:assignedEntity/v3:representedOrganization"/>
                                <xsl:apply-templates mode="print" select="//v3:subject/v3:manufacturedProduct"/>
                            </div>
                        </div>
                    </div>
                </div>				
            </div>
        </main>	
    </xsl:template>
    
    <!-- [pmh] override Bootstrap 4 accordions with Bootstrap 3 accordions -->
    <!-- accordion card for company details and distributor details - note the spl class that triggers FDA styles -->
    <xsl:template mode="screen" match="//v3:author/v3:assignedEntity/v3:representedOrganization">
        <li id="company-details" class="m-2">
            <details>
                <summary>
                    <xsl:value-of select="$labels/companyDetails[@lang = $lang]"/>					
                </summary>
                <div class="spl m-0">
                    <xsl:apply-templates mode="subjects" select="."/>
                    <xsl:apply-templates mode="subjects" select="v3:assignedEntity/v3:assignedOrganization"/>
                </div>
            </details>
        </li>								
    </xsl:template>
    
    <!-- accordion card for product details - note the spl class that triggers FDA styles -->
    <xsl:template mode="screen" match="v3:subject/v3:manufacturedProduct">
        <xsl:variable name="unique-product-id">product-<xsl:value-of select="position()"/></xsl:variable>
        <li id="{$unique-product-id}" class="m-2">
            <details>
                <summary>
                    <xsl:apply-templates select="v3:manufacturedProduct" mode="generateUniqueLabel">
                        <xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
                    </xsl:apply-templates>						
                </summary>
                <div class="spl m-0">
                    <xsl:apply-templates mode="subjects" select="."/>
                </div>
            </details>
        </li>								
    </xsl:template>
    
</xsl:transform>