*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${STUDENT}=       Y4ILM9
${Path}=          ../${STUDENT}/exercise_01.html

*** Test Cases ***
EXERCISE1 - HTML5 / CSS ALAPOK (1.)
    [Tags]                     owner-richard.zilahi  group=validating
    ${ExerciseFile}=           OperatingSystem.Get File    ${Path}    encoding=UTF-8    encoding_errors=strict
    Open Browser And Navigate To Site  ${Path}
    Capture Page Screenshot
    ${PageTitle}=              Get Title
    ${IsPageTitleOk}=          Run Keyword And Ignore Error  Should Be Equal As Strings    ${PageTitle}    ${STUDENT}  Az oldal <title> tag nem megfelelő!  false
    Log                        Check page title: ${IsPageTitleOk[0]}  level=WARN
