*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${Path}=          ../exercise-03/index.html
${CssPath}=       ../exercise-03/css/alap.css

*** Test Cases ***
3. GYAKORLATI FELADAT
    [Tags]                     owner-richard.zilahi  group=validating
    ${FinalPoints}=            Set Variable  0
    Open Browser And Navigate To Site  ${Path}
    ${IndexTitlePoints}=       Check Webpage Title  A legjobb internetes/webes témájú filmek - Kezdőlap
    ${DoctypePoints}=          Check Doctype Declaration  ${Path}
    ${CountHeaderTag}=         Check Html Tag Exist  ${Path}  header  1
    ${CountNavTag}=            Check Html Tag Exist  ${Path}  nav  1
    #Check Page Links           valami  #TODO: FINISH THIS
    ${CountMainTagPoints}=     Check Html Tag Exist  ${Path}  main  1
    ${CountFooterTagPoints}=   Check Html Tag Exist  ${Path}  footer  1
    ${CountArticleTag}=        Check Html Tag Exist  ${Path}  article  4
    ${CountAsideTagPoints}=    Check Html Tag Exist  ${Path}  aside  4
    ${CountFigureTagPoints}=   Check Html Tag Exist  ${Path}  figure  4
    ${BevezetoElementPoints}=  Check For Element  xpath=//*[@id="bevezeto"]
    ${KozossegiHaloTitle}=     Check For Element  xpath=//*[@id="kozossegihalo"]
    ${AnoTitlePoints}=         Check For Element  xpath=//*[@id="ano"]
    ${TemegEnTitlePoints}=     Check For Element  xpath=//*[@id="temegen"]
    ${DeepwebTitlePoints}=     Check For Element  xpath=//*[@id="deepweb"]
    ${CountPTags}=             Count Matching Xpath  //article/p  9

    #CHECK CSS FILE
    ${CurrentPoints}=          Set Variable    0
    ${BodyFontFamilyList}=     getAttributeValue  ${CssPath}  body  font-family
    @{List}                    Split String  ${BodyFontFamilyList}  ,
    ${Length}=                 Get Length  ${List}
    : FOR                      ${i}  IN RANGE  0  ${Length}
    \                          ${CurrentPoints}=  Check FontFamily  ${CssPath}  body  font-family  ${List[${i}]}  ${CurrentPoints}

    ${CheckFontSizeInH1TagPoints}=  Check Css Property  ${CssPath}  h1  font-size  3em
    ${CheckSmallCapsInH1TagsPoints}=  Check Css Property  ${CssPath}  h1  font-variant  small-caps;
    ${CheckTextAlignInH1TagsPoints}=  Check Css Property  ${CssPath}  h1  text-align  center
    ${CheckLetterSpacingInH1TagsPoints}=  Check Css Property  ${CssPath}  h1  letter-spacing  2px

    ${CheckFontSizeInH2TagPoints}=  Check Css Property  ${CssPath}  h2  font-size  2em

    ${CheckFontSizeInH3TagPoints}=  Check Css Property  ${CssPath}  h3  font-size  1.5em
    ${CheckTextIndentInH3TagPoints}=  Check Css Property  ${CssPath}  h3  text-indent  2em

    ${CheckTextAlignInFigcationTagPoints}=  Check Css Property  ${CssPath}  figcaption  text-align  center
    ${CheckFontWeightInFigcationTagPoints}=  Check Css Property  ${CssPath}  figcaption  font-weight  bold
    ${CheckTextAlignInPTagsPoints}=  Check Css Property  ${CssPath}  p  text-align  justify
    ${CheckLineHeightInPTags}=       Check Css Property  ${CssPath}  p  line-height  1.5em
    ${CheckFontStyleInQTags}=        Check Css Property  ${CssPath}  q  font-style  italic
    ${CheckTextAlignInFooterPNavTags}=  Check Css Property  ${CssPath}  footer p, nav#fomenu  text-align  center
    ${CheckTextAlignInThTags}=       Check Css Property  ${CssPath}  th  text-align  left

    [Teardown]                 Run Keywords  Close All Browsers
