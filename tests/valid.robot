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
    Check If Submit Form Is Properly Used  ${AllPages}
    Check If The Page Has At Least 3 External Links  ${AllPages}
    Check Html 5 Tags  ${AllPages}
    Check Pages Title Tag            ${AllPages}
    Check If CSS Has Proper Font Settings  ${STUDENT}
    Check If There Is Any Fails    ${IsAllOk}
    [Teardown]                 Run Keywords    Close All Browsers
