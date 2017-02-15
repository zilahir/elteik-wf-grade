*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${STUDENT}=       Y4ILM9
#${Path}=          ../${STUDENT}/exercise_01.html
${Path}=          exercise_01.html

*** Test Cases ***
EXERCISE1 - HTML5 / CSS ALAPOK (1.)
    [Tags]                     owner-richard.zilahi  group=validating
    ${ExerciseFile}=           OperatingSystem.Get File    ${Path}    encoding=UTF-8    encoding_errors=strict
    Open Browser And Navigate To Site  ${Path}
    Capture Page Screenshot
    ${PageTitle}=              Get Title
    ${IsPageTitleOk}=          Run Keyword And Ignore Error  Should Be Equal As Strings    ${PageTitle}    ${STUDENT}  Az oldal <title> tag nem megfelelő!  false
    #Log                        Check page title: ${IsPageTitleOk[0]}  level=WARN

    ${Group1}  ${Group2}  ${Group3}  ${Group4}=
    ...                       BuiltIn.Should Match Regexp        ${ExerciseFile}    ${HtmlDeclarationRegex}    msg=None    values=True
    ${IsDoctypeOk}=           Run Keyword And Ignore Error  Should Be Equal As Strings  ${Group3}  DOCTYPE html
    #Log                       Check the doctype: ${IsDoctypeOk[0]}  level=WARN
    ${IsClassHasRedProperty}=  IsCssClassHasKeyValuePair  exercise1.css  .red  color  ${RedColor}
    ${RedColorResult}=         Set Variable If    '${IsClassHasRedProperty}'=='true'  PASS  FAIL
    #Log                       .red class text color ${RedColorResult}  level=WARN
    ${IsTextUnderlinedResult}=  IsCssClassHasKeyValuePair  exercise1.css  .welcome  text-decoration  underline
    ${IsTextUnderlined}=         Set Variable If    '${IsTextUnderlinedResult}'=='true'  PASS  FAIL
    #Log                       .welcome class underline property ${IsTextUnderlined}  level=WARN
    ${ResultJson}=             Create Dictionary  pagetitle=${IsPageTitleOk[0]}  doctype=${IsDoctypeOk[0]}  redclass=${RedColorResult}  underlinepropery=${IsTextUnderlined}
    Console log               ${ResultJson}  level=WARN
    [Teardown]                Run Keywords    Close All Browsers
