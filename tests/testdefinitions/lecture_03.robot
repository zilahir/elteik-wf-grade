*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${Path}=          ../lecture_03/index.html

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
    ${CountMainTag}=           Check Html Tag Exist  ${Path}  main  1
    ${CountFooterTagPoints}=   Check Html Tag Exist  ${Path}  footer  1
    ${CountArticleTag}=        Check Html Tag Exist  ${Path}  article  4
    ${CountAsideTag}=          Check Html Tag Exist  ${Path}  aside  4
    ${CountFigureTag}=         Check Html Tag Exist  ${Path}  figure  4
    ${BevezetoElementPoints}=  Check For Element  xpath=//*[@id="bevezeto"]
    ${KozossegiHaloTitle}=     Check For Element  xpath=//*[@id="kozossegihalo"]
    ${AnoTitlePoints}=         Check For Element  xpath=//*[@id="ano"]
    ${TemegEnTitlePoints}=     Check For Element  xpath=//*[@id="temegen"]
    ${DeepwebTitlePoints}=     Check For Element  xpath=//*[@id="deepweb"]
    ${CountPTags}=             Count Matching Xpath  //article/p  9

    #CHECK CSS FILE
    ${IsFontOkay}=             IsCssClassHasKeyValuePair  ../lecture_03/css/alap.css  body  font-family  Arial, Verdana, sans-serif
    [Teardown]                 Run Keywords  Close All Browsers
