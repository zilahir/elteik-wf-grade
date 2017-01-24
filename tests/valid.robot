*** Settings ***
Resource                     common_resource.robot

*** Variables ***

${STUDENT}=       BI7TW8

*** Test Cases ***
TEST1-Validating HTML Files
    [Tags]                     owner-richard.zilahi  group=validating
    ${AllPages}=               Get All Subpages           ${STUDENT}
    Validate One Individual Page  ${AllPages}
    Check If Page Contains Background Image  ${STUDENT}
    Validate CSS File          ${STUDENT}/style/style.css
    Check For At Least For Minimum Images  ${AllPages}
    Check If Tables Are Properly Used  ${AllPages}
    [Teardown]                 Run Keywords    Close All Browsers
