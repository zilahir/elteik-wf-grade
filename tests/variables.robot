*** Settings ***

*** Variables ***

${MenuContainer}               //nav/ul/li
${HasBgImagePattern}           *url(*.png)*
${ImgHtmlTag}                  //img
${CssFontFamilyRegexp}         (font-family:.')(.*)('.*)(;)
#${CssFontSizeRegexp}           (font-size. ?)(\d{1,3})(%)(.*)
${CssFontSizeRegexp}           (font-size. ?)(\d{1,3})(px)(;)
*** Keywords ***
