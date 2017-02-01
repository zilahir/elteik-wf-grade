*** Settings ***
Resource                     ../resources/common_resource.robot

*** Variables ***

${STUDENT}=       Y4ILM9
${Path}=          ../${STUDENT}/exercise_03.html

*** Test Cases ***
EXERCISE1 - HTML5 / CSS ALAPOK (3.)
    [Tags]                     owner-richard.zilahi  group=validating
    ${Result}=                Create List
    ${CssResult}=             Create List
    ${ExerciseFile}=           OperatingSystem.Get File    ${Path}    encoding=UTF-8    encoding_errors=strict
    Open Browser And Navigate To Site  ${Path}
    ${IsThereAllThePTags}=     Run Keyword And Ignore Error  Locator Should Match X Times  ${PTagLocator}  4
    Run Keyword If            '${IsThereAllThePTags[0]}'=='FAIL'  Append To List    ${Result}  ${IsThereAllThePTags[0]}
    ${IsAlignLeft}=           IsCssClassHasKeyValuePair  ../${STUDENT}/exercise3.css  .balraigazit  text-align  left
    ${IsAlignRight}=          IsCssClassHasKeyValuePair  ../${STUDENT}/exercise3.css  .jobbraigazit  text-align  right
    ${IsAlignCenter}=         IsCssClassHasKeyValuePair  ../${STUDENT}/exercise3.css  .kozepreigazit  text-align  center
    ${isAlignJustify}=        IsCssClassHasKeyValuePair  ../${STUDENT}/exercise3.css  .sorkizart  text-align  justify
    Run Keyword If            '${IsAlignLeft}'=='false'  Append To List  ${CssResult}  FAIL
    Run Keyword If            '${IsAlignRight}'=='false'  Append To List  ${CssResult}  FAIL
    Run Keyword If            '${IsAlignCenter}'=='false'  Append To List  ${CssResult}  FAIL
    Run Keyword If            '${isAlignJustify}'=='false'  Append To List  ${CssResult}  FAIL
    ${CssResultLength}=       Get Length    ${CssResult}
    Log                       ${CssResultLength}  level=WARN
    Should Be Equal As Integers    ${CssResultLength}  0  Nem teljesült minden feltétel  false
    Capture Page Screenshot
    [Teardown]                Run Keywords    Close All Browsers
