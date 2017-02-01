*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${STUDENT}=       Y4ILM9
${Path}=          ../${STUDENT}/exercise_02.html

*** Test Cases ***
EXERCISE2 - HTML5 / CSS ALAPOK (1.)
    [Tags]                     owner-richard.zilahi  group=validating
    ${ExerciseFile}=           OperatingSystem.Get File    ${Path}    encoding=UTF-8    encoding_errors=strict
    Open Browser And Navigate To Site  ${Path}
    Capture Page Screenshot
    ${Result}=                Create List
    ${Width}=                 Selenium2Library.Get Element Attribute  elsokep@width
    ${Height}=                Selenium2Library.Get Element Attribute  elsokep@height
    ${Alt}=                   Selenium2Library.Get Element Attribute  elsokep@alt
    ${Title}=                 Selenium2Library.Get Element Attribute  elsokep@title
    ${IsWidth}=               Run Keyword And Ignore Error  Should Not Be Empty  ${Width}  msg=None
    ${IsHeight}=              Run Keyword And Ignore Error  Should Not Be Empty  ${Height}  msg=None
    ${IsAlt}=                 Run Keyword And Ignore Error  Should Not Be Empty  ${Alt}  msg=None
    ${IsTitle}=               Run Keyword And Ignore Error  Should Not Be Empty  ${Title}  msg=None
    Run Keyword If            '${IsWidth[0]}'=='FAIL'  Append To List    ${Result}  ${IsWidth[0]}
    Run Keyword If            '${IsHeight[0]}'=='FAIL'  Append To List    ${Result}  ${IsHeight[0]}
    Run Keyword If            '${IsAlt[0]}'=='FAIL'  Append To List    ${Result}  ${IsAlt[0]}
    Run Keyword If            '${IsTitle[0]}'=='FAIL'  Append To List    ${Result}  ${IsTitle[0]}
    Should Be Empty           ${Result}  Nem teljesült minden feltétel
    Run Keyword If            '${Result}'=='${EMPTY}'  Log  Minden feltétel teljesült!
    [Teardown]                Run Keywords    Close All Browsers
