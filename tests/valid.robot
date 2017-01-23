*** Settings ***
Resource                     common_resource.robot

*** Variables ***

${STUDENT}=       BI7TW8

*** Test Cases ***
TEST1-Validating HTML Files
    [Tags]                     owner-richard.zilahi  group=validating
    ${AllPages}=               Get All Subpages           ${STUDENT}
    Validate One Individual Page  ${AllPages}
    Validate CSS File          ${STUDENT}/style/style.css
    [Teardown]                 Run Keywords    Close All Browsers
