Key Links:
README: https://healthcanada.github.io/HPFB/product-monograph/style-sheet
XSL: https://healthcanada.github.io/HPFB/product-monograph/style-sheet/spl_canada.xsl
(or https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/style-sheet/spl_canada.xsl)
CSS: https://healthcanada.github.io/HPFB/product-monograph/style-sheet/spl_canada.css
XSD: https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/schema/SPL.xsd

1. Add the Development folder as a sibling to the other folders in Samples from Dropbox.

Manifest
 - style-sheets/spl_canada.xsl
 - style-sheets/spl_canada_screen.xsl
 - style-sheets/spl_canada_i18n.xsl
 - style-sheets/FDA spl_stylesheet_6_2/...
 - style-sheets/spl_canada.css
 
The spl_canada.xsl stylesheet references its siblings, spl_canada_screen.xsl, and spl_canada_i18n.xsl,
and it also relies on the templates in FDA spl_stylesheet_6_2. The spl_canada.xsl stylesheet contains the 
root template and a number of templates which override the corresponding templates if the FDA XSL. 
The other two stylesheets provide templates for onscreen navigation and bilingual language support.

2. This should be the only processing instruction referenced in the SPM XML:

<?xml-stylesheet type="text/xsl" href="https://raw.githubusercontent.com/HealthCanada/HPFB/master/product-monograph/style-sheet/spl_canada.xsl"?>

Once you change the stylesheet processing instruction in one of the SPM XML files, 
you should be able to transform it into HTML using Oxygen or a similar XML tool, and then render it 
using your local browser.

3. Aurora and FDA Stylesheets

We are currently using the FDA styles for styles within the drug monograph itself, and the Bootstrap
Bundle contained styles. These are similar to the styles referenced in the Aurora Design Guide, although
we are not using the actual Aurora javascript and css. The Bootstrap 4 Bundle contains the Popper library,
and we are also using the JQuery Slim version and StickyFill polyfill library.

Bootstrap 4 provides exceptional modern browser support, and aligns closely with Aurora. Alternatively,
we could use Bootstrap 3, which provides broader support for older browsers. Their are advantages to
both approaches. We are currently testing with the latest versions of Internet Explorer, Edge and Firefox.
Future plans involve creating Health Canada specific css which will replace the FDA css, and can then
be used in conjunction with the Bootstrap css and javascript. The FDA javascript is no longer needed.

4. Web Navigation and Responsive Design

Sidebar navigation is hidden for small screen sizes and can be used on larger screens. Sidebar
navigation and the accordion collapsing is essentially the same thing: clicking a menu item and
the corresponding accordion header have the same effect. In both cases, the behaviour is to show
or hide a section of content.

Bootstrap Scrollspy is a library which synchronizes scrolling and navigation. The navigation menu 
currently does not extend below the second level of sections.

In the current implementation, the width of the sidebar navigation has been fixed to 400px to
resolve an issue I discovered with accordion resizing. Realistically, it makes sense to fix the
sidebar navigation size to always fit the longest expected top level heading.

5. Internationalization, Labels and Local Date Formats

Internationalization and local date formatting maintained in the spl_canada_i18n.xsl transform file.
Where it is possible, Display Names should be used. Where static labels are required, these need to
be internationalized. These are necessary for any fields that are Required but not Mandatory.

6. Decisions Required

 - There are advantages to using Bootstrap 3 vs. Bootstrap 4. Both are viable options and we are 
   currently using BS4. They provide different kinds of compatability with modern and older browsers.
   
 - We are currently importing the FDA XSL into our transformation, and we may eventually no longer
   require any of the common FDA elements. These should be decoupled.
   
 - We are currently referencing a copy of the FDA spl.css, called spl_canada.css, the Bootstrap CSS,
   and some local CSS. The local CSS will be merged into spl_canada.css. In the final version, there will 
   only be a requirement for two CSS files, the bootstrap.css, and a separate spl_canada.css file, 
   which blends .spl classes with aurora classes and some scaffolding for our screen and print views.
   
 - We are currently working with CSS3 Paged Media to support a print view, as opposed to using XSL:FO
   to generate a separate PDF document. Both are viable options, but Paged Media is a simplied approach.

7. Known Issues

 - Print TOC does not exist.
 - There is a minor problem with responsive resizing at some screen resolutions which causes content to render under the navigation sidebar.
 
 There are limitations with client-side rendering on each of the major browsers, which is why we recommend 
 using Oxygen or a similar tool. If we host our XSL on Github Pages, there is a limitation for Chrome, 
 because Chrome serves XSL as application/xml,rather than text/xml, as described at the bottom of this thread:
 https://stackoverflow.com/questions/2981524/how-can-i-make-xslt-work-in-chrome
 
 Using WeasyPrint Service from Docker Container from BC Gov:
 curl -v -X POST -d @test.htm -JLO http://127.0.0.1:5002/pdf?filename=result.pdf
 
