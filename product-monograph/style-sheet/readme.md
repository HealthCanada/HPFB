Key Links:
README: https://healthcanada.github.io/HPFB/product-monograph/style-sheet
XSL: https://healthcanada.github.io/HPFB/product-monograph/style-sheet/spl_canada.xsl
(or https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/style-sheet/spl_canada.xsl)
CSS: https://healthcanada.github.io/HPFB/product-monograph/style-sheet/spl_canada.css
XSD: https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/schema/SPL.xsd

1. Manifest
 - style-sheets/spl_canada.xsl
 - style-sheets/spl_canada_screen.xsl
 - style-sheets/spl_canada_i18n.xsl
 - style-sheets/FDA spl_stylesheet_6_2/...
 - style-sheets/spl_canada.css
 
The spl_canada.xsl stylesheet references its siblings, spl_canada_screen.xsl, and spl_canada_i18n.xsl,
and it also relies on the templates in FDA spl_stylesheet_6_2. The spl_canada.xsl stylesheet contains the 
root template and a number of templates which override the corresponding templates in the FDA XSL. 
The other two stylesheets provide templates for onscreen navigation and bilingual language support.

2. This should be the only processing instruction referenced in the SPM XML:

<?xml-stylesheet type="text/xsl" href="https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/style-sheet/spl_canada.xsl"?>

3. Aurora and FDA Stylesheets

We are currently using the FDA styles for styles within the drug monograph itself, and the Bootstrap
Bundle contained styles. These are similar to the styles referenced in the Aurora Design Guide, although
we are not using the actual Aurora javascript and css. The Bootstrap 4 Bundle contains the Popper library,
and we are also using the JQuery Slim version and StickyFill polyfill library.

Bootstrap 4 provides exceptional modern browser support, and aligns closely with Aurora. Future plans involve creating Health Canada specific css which will replace the FDA css, and can then be used in conjunction with the Bootstrap css and javascript.

4. Web Navigation and Responsive Design

Sidebar navigation is hidden for small screen sizes and can be used on larger screens. Sidebar
navigation and the accordion collapsing is essentially the same thing: clicking a menu item and
the corresponding accordion header have the same effect. In both cases, the behaviour is to show
or hide a section of content.

Bootstrap Scrollspy is a library which synchronizes scrolling and navigation. The navigation menu 
currently does not extend below the second level of sections.

In the current implementation, the width of the sidebar navigation has been fixed to 400px to
resolve an issue discovered with accordion resizing. 

5. Internationalization, Labels and Local Date Formats

Internationalization and local date formatting maintained in the spl_canada_i18n.xsl transform file.
Where it is possible, Display Names should be used. Where static labels are required, these need to
be internationalized. These are necessary for any fields that are Required but not Mandatory.

6. Known Issues

 - Print TOC does not exist.
 - There is a minor problem with responsive resizing at some screen resolutions which causes content to render under the navigation sidebar.
