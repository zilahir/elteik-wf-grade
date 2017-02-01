*** Settings ***

*** Variables ***

${MenuContainer}               //nav/ul/li
${HasBgImagePattern}           *url(*.png)*
${ImgHtmlTag}                  //img
${CssFontFamilyRegexp}         (font-family:.')(.*)('.*)(;)
#${CssFontSizeRegexp}           (font-size. ?)(\d{1,3})(%)(.*)
${CssFontSizeRegexp}           (font-size. ?)(\d{1,3})(px)(;)
#${VisitedCssNode}               \n[^:]*:visited\\s*{\s*([^}]*)}
#${VisitedCssNode2}               \n[^:]*a:hover\\s*{\s*([^}]*)}
${GetImagesXpath}              (<img.*>.*)
*** Keywords ***
