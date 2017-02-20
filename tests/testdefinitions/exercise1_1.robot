*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${STUDENT}=       Y4ILM9
#${Path}=          ../${STUDENT}/exercise_01.html
${Path}=          exercise_01.html

*** Test Cases ***
EXERCISE1 - HTML5 / CSS ALAPOK (1.)
    [Tags]                     owner-richard.zilahi  group=validating
    ${FinalPoints}=            Set Variable  0
    #${FinalPoints}=            Convert To Number    ${FinalPoints}
    ${ExerciseFile}=           OperatingSystem.Get File    ${Path}    encoding=UTF-8    encoding_errors=strict
    Open Browser And Navigate To Site  ${Path}
    Capture Page Screenshot
    ${PageTitle}=              Get Title
    ${IsPageTitleOk}=          Run Keyword And Ignore Error  Should Be Equal As Strings    ${PageTitle}    ${STUDENT}  Az oldal <title> tag nem megfelelő!  false
    Run Keyword If            "${IsPageTitleOk[0]}" == "PASS"  ${FinalPoints}=    Evaluate    0+10
    ${Group1}  ${Group2}  ${Group3}  ${Group4}=
    ...                       BuiltIn.Should Match Regexp        ${ExerciseFile}    ${HtmlDeclarationRegex}    msg=None    values=True
    ${IsDoctypeOk}=           Run Keyword And Ignore Error  Should Be Equal As Strings  ${Group3}  DOCTYPE html
    Run Keyword If            "${IsDoctypeOk[0]}" == "PASS"  ${FinalPoints}=  Evaluate    ${FinalPoints}+30
    ${IsClassHasRedProperty}=  IsCssClassHasKeyValuePair  exercise1.css  .red  color  ${RedColor}
    ${RedColorResult}=         Set Variable If    '${IsClassHasRedProperty}'=='true'  PASS  FAIL
    Run Keyword If            "${RedColorResult}" == "PASS"  ${FinalPoints}=  Evaluate    ${FinalPoints}+30
    ${IsTextUnderlinedResult}=  IsCssClassHasKeyValuePair  exercise1.css  .welcome  text-decoration  underline
    ${IsTextUnderlined}=         Set Variable If    '${IsTextUnderlinedResult}'=='true'  PASS  FAIL
    Run Keyword If            "${IsTextUnderlined}" == "PASS"  ${FinalPoints}=  Evaluate    ${FinalPoints}+30
    ${json_string}=    catenate
    ...  ***{
    ...    "pagetitle": "${IsPageTitleOk[0]}",
    ...    "doctype": "${IsDoctypeOk[0]}",
    ...    "redclass": "${RedColorResult}",
    ...    "underlinepropery" : "${IsTextUnderlined}",
    ...    "points" : "${FinalPoints}"
    ...  }***
    log to console            ${json_string}
    [Teardown]                Run Keywords    Close All Browsers
