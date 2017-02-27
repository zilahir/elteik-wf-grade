*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${Path}=          ../lecture_03/index.html

*** Test Cases ***
3. GYAKORLATI FELADAT
    [Tags]                     owner-richard.zilahi  group=validating
    ${FinalPoints}=            Set Variable  0
    Check Doctype Declaration  ${path}
    #CHECK HTML5 VALIDATION
    [Teardown]                 Run Keywords
