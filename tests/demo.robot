*** Settings ***
Resource                     common_resource.robot

*** Variables ***

${STUDENT}=       BI7TW8

*** Test Cases ***
TEST1-Validating HTML Files
    [Tags]                     owner-richard.zilahi  group=validating
    ${Result}=                 IsCssClassHasKeyValuePair  ${STUDENT}/style/style.css  .center  text-align  center
    ${Result2}=                IsCssClassHasKeyValuePair  ${STUDENT}/style/style.css  .left  float  left
    Log                        ${Result}  level=WARN
    Log                        ${Result2}  level=WARN
