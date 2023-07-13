# XML Product Monograph Stylesheets - Version 1.0

## 1. Manifest

spl_canada.xsl  
spl_canada_screen.xsl  
spl_canada_i18n.xsl  
spl_common.xsl  
spl_canada.css  
 
The spl_canada.xsl stylesheet references its siblings, spl_canada_screen.xsl, and spl_canada_i18n.xsl, and it also relies on some common templates that were inherited from the FDA. The spl_canada.xsl stylesheet contains the root template and a number of templates which override the corresponding templates in the FDA XSL. 
The other two stylesheets provide templates for onscreen navigation and bilingual language support.
Additional stylesheets for Consumer and Product Monograph views support rendering during publication.

## 2. Revision Log

"Legacy" Changes
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
2021-08-09 - Removed rule for First Paragraph StyleCode, which interferes with Boxed Statement  
2021-08-20 - Use local numbers instead of footnote marks, and change styles to allow space for doucle digits  
2021-09-10 - Resolved issue with footnote numbers, override footnote marks template to always use local numbers instead 
2021-11-29 - Support for multiple Companies and Addresses on PM Title Page  
2022-01-21 - [#93, #94] Use Basis of Strength in Product Detail section headings, render French physical quantity values using commas and spaces  
2022-02-11 - [#109] Support multiple company and address blocks with CSS min height on .title-page-left rather than conditional padding  
2022-04-08 - [#120] Cleaner styling when xmChange in paragraph with Boxed Warning
2021-05-09 - [#68] CSS Support for table-shading using styleCode=table-secondary

"v_1_0" Changes:
2021-10-29 - [#68] Support for multiple Companies and Addresses on PM Title Page; table-shading using styleCode=table-secondary  
2021-11-26 - Added Product Metadata section for Print back to spl_canada_monograph.spl  
2022-01-14 - [#93, #94] Use Basis of Strength in Product Detail section headings, render French physical quantity values using commas and spaces  
2022-02-04 - [#109] Support multiple company and address blocks with padding that works with paragraph and br delimited addresses  
2022-02-11 - [#109] Support multiple company and address blocks with CSS min height rather than conditional padding  
2022-06-17 - [#124, #138] Packaging description changes, including "See Below" and label changes for Multipart, stop relying on CV code C43197, swap Product Status and Packaging Status  
2022-09-21 - [#134, #136] left justify title page footer, added support for Date First Authorized for Current Owner, with conditional extra padding
2022-11-03 - [#140, #141] remove bolding from active/inactive ingredient names; left align table captions
2023-04-07 - [#158, #162] French language label changes for "#" etc; allow multiple occurences of Size Characteristic  
2023-06-26 - [#158] Additional French language label changes for "#"  
2023-07-13 - Refactoring to remove Jump to Top, and simplify section-view parameters as described below

## 3. This should be the only processing instruction referenced in the XML PM:

    <?xml-stylesheet type="text/xsl" href="https://health-products.canada.ca/product-monograph/stylesheet/v_1_0/spl_canada.xsl"?>

## 4. Bootstrap, Web Navigation and Responsive Design

We use our own styles, in spl_canada.css, and the Bootstrap Bundle contained styles and JavaScript. The Bootstrap 4 Bundle contains the Popper library, and we are also using the JQuery Slim version and StickyFill polyfill library. Bootstrap 4 provides exceptional modern browser support, and aligns closely with the Aurora Design Guide, whereas Bootstrap 3 more closely aligns with current wet-boew guidance.

Sidebar navigation is hidden for small screen sizes and can be used on larger screens. Sidebar navigation and accordion collapsing is essentially the same thing: clicking a menu item and the corresponding accordion header have the same effect. In both cases, the behaviour is to show or hide a section of content. In the current implementation, the width of the sidebar navigation has been fixed to 400px to resolve an issue discovered with accordion resizing. 

Bootstrap Scrollspy is a library which synchronizes scrolling and navigation. The navigation menu currently does not extend below the second level of sections.

## 5. Internationalization, Labels and Local Date Formats

Internationalization and local date formatting maintained in the spl_canada_i18n.xsl transform file. Where it is possible, Display Names should be used. Where static labels are required, these need to be internationalized. These are necessary for any fields that are Required but not Mandatory.

## 6. Key Links and Views

XSL: https://health-products.canada.ca/product-monograph/style-sheet/v_1_0/spl_canada.xsl  
CSS: https://health-products.canada.ca/product-monograph/style-sheet/v_1_0/spl_canada.css  
XSD: https://health-products.canada.ca/product-monograph/schema/SPL.xsd  

The following parameterized views are supported:
- $show-section='#pmi00' - return just a WET-BOEW compliant HTML section for Patient Medication Information
- $show-section='review' - return the full product monograph with additional review information
