*** Settings ***
Documentation
Resource                     common_resource.robot


*** Variables ***

*** Test Cases ***
TEST1-Validating HTML Files
    [Tags]                     owner-richard.zilahi  group=validating
    Validate One Individual Page  lofasz
