# XML Product Monograph Stylesheets - Version 1.0

## 1. Manifest

spl_canada.xsl  
spl_canada_screen.xsl  
spl_canada_i18n.xsl  
spl_common.xsl  
spl_canada.css  
 
The spl_canada.xsl stylesheet references its siblings, spl_canada_screen.xsl, and spl_canada_i18n.xsl, and it also relies on some common templates that were inherited from the FDA. The spl_canada.xsl stylesheet contains the root template and a number of templates which override the corresponding templates in the FDA XSL. 
The other two stylesheets provide templates for onscreen navigation and bilingual language support.

## 2. Change Log

2021-01-08 - Removed Combination Product Type Characteristic; renamed Packaging Availability, removed Packaging Cancellation Date and Product Approval Status  
2021-01-22 - Added optional parameter base-uri to support passing in absolute image base uri for server-side rendering; use section.root.id for subsection navigation  
2021-02-12 - Minor changes to Title Page and print table of contents  
2021-02-10 - Hide NON/c and BBD print headers, and exclude genericode namespaces  
2021-02-26 - Various Accessibility changes to align more closely with wet-boew guidelines - h1 and h2 headers  
2021-03-05 - Various Accessibility changes to align more closely with wet-boew guidelines - extraneous company detail tables  
2021-03-09 - Resolved HTML5 output encoding issue which was preventing w3c validation  
2021-03-12 - Various Accessibility changes to align more closely with wet-boew guidelines  
2021-03-19 - Various Accessibility changes to align more closely with wet-boew guidelines  
2021-05-07 - Moved Product Details to bottom of Content and Navigation sections; added Date formatting on Title Page  
2021-06-11 - Product Composition Changes to consolidate Ingredients into a single table within the Product Metadata  
2021-07-09 - Removed special table logic for Recent Major Label Changes section, which previously had suppressed table styles  
2021-07-16 - Added styles for styleCodes Boxed, First, and Last to support Boxed Statement around consecutive SPL text elements (paragraph and list)  

## 3. This should be the only processing instruction referenced in the SPM XML:

    <?xml-stylesheet type="text/xsl" href="https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/stylesheet/v_1_1/spl_canada.xsl"?>

## 4. Bootstrap, Web Navigation and Responsive Design

We use our own styles, in spl_canada.css, and the Bootstrap Bundle contained styles and JavaScript. The Bootstrap 4 Bundle contains the Popper library, and we are also using the JQuery Slim version and StickyFill polyfill library. Bootstrap 4 provides exceptional modern browser support, and aligns closely with the Aurora Design Guide, whereas Bootstrap 3 more closely aligns with current wet-boew guidance.

Sidebar navigation is hidden for small screen sizes and can be used on larger screens. Sidebar navigation and accordion collapsing is essentially the same thing: clicking a menu item and the corresponding accordion header have the same effect. In both cases, the behaviour is to show or hide a section of content. In the current implementation, the width of the sidebar navigation has been fixed to 400px to resolve an issue discovered with accordion resizing. 

Bootstrap Scrollspy is a library which synchronizes scrolling and navigation. The navigation menu currently does not extend below the second level of sections.

## 5. Internationalization, Labels and Local Date Formats

Internationalization and local date formatting maintained in the spl_canada_i18n.xsl transform file. Where it is possible, Display Names should be used. Where static labels are required, these need to be internationalized. These are necessary for any fields that are Required but not Mandatory.

## 6. Key Links

XSL: https://healthcanada.github.io/HPFB/product-monograph/style-sheet/v_1_0/spl_canada.xsl  
(or https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/v_1_0/style-sheet/spl_canada.xsl)  
CSS: https://healthcanada.github.io/HPFB/product-monograph/style-sheet/v_1_0/spl_canada.css  
XSD: https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/schema/SPL.xsd  
