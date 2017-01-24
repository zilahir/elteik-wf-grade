*** Settings ***
Library           String
Library           Selenium2Library
Library           XvfbRobot
Library           OperatingSystem
Library           DateTime
Library           BuiltIn
Library           String
Library           SSHLibrary
Library           Collections
Library           XML
Library           HttpLibrary.HTTP

Resource                     variables.robot

*** Variables ***

${BROWSER}=       phantomjs

*** Keywords ***

Check If Tables Are Properly Used
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}
    ${Result}=                 Set Variable    0
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/${ListOfPages[${i}]}
    \                          ${CurrentCount}  Get Count  ${CurrentFile}  <details
    \                          ${Result}=  Evaluate    ${Result}+${CurrentCount}
    ${IsCaptionTagVisibleResult}=  Run Keyword And Ignore Error  Should Be True    ${Result}>0
    Log                        Is the page has at least 1 caption tag: ${IsCaptionTagVisibleResult[0]}  level=WARN


Check For At Least For Minimum Images
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}
    ${Result}=                 Set Variable    0
    Log                        ${Length}
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/${ListOfPages[${i}]}
    \                          ${CurrentCount}  Get Count  ${CurrentFile}  <img
    \                          ${Result}=  Evaluate    ${Result}+${CurrentCount}
    ${IsAtLeast5Images}=       Run Keyword And Ignore Error  Should Be True    ${Result}>5
    Log                        Is the page has at least 5 images: ${IsAtLeast5Images[0]}  level=WARN

    #Log  ${Result}  level=WARN


Check If Page Contains Background Image
   [Arguments]                ${Student}
   ${CssFiles}=               OperatingSystem.List Files In Directory    ${Student}/style/    *.css    absolute=False
   ${Length}=                 Get Length  ${CssFiles}
   #${Length}=                 Convert To Integer    ${Length}
   : FOR                      ${i}  IN RANGE  0  ${Length}
   #\                          Log  ${CssFiles[${i}]}  level=WARN
   \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/style/${CssFiles[${i}]}
   \                          ${TestResult}  Run Keyword And Ignore Error  BuiltIn.Should Match  ${CurrentFile}  ${HasBgImagePattern}
   \                          Log  Check If Page Contains Background Image: ${CssFiles[${i}]} ${TestResult[0]}  level=WARN

Validate CSS File
   [Arguments]                 ${File}
   ${Output}=                  Run  curl -s -H "Content-Type: text/html; charset=utf-8" --data-binary @${File} https://validator.w3.org/nu/?out=xml
   Create File                 css.xml  content=${Output}  encoding=UTF-8
   ${TestResult}               Run Keyword And Ignore Error  XML.Element Should Not Exist  ${Output}  error  A következő oldal nem valid: ${File}
   Log                         Validation the following page: ${File} ${TestResult[0]}  level=WARN


Open Browser And Navigate To Site
   [Documentation]             Opens the desired browser with eir page, and logs in
   [Arguments]                 ${Url}
   Open Browser                ${Url}  ${BROWSER}
   #Set Window Size             1280  900
   Capture Page Screenshot

Validate One Individual Page
  [Arguments]                ${ListOfPages}
  ${Length}=                 Get Length  ${ListOfPages}
  Log                        ${Length}
  : FOR                      ${i}  IN RANGE  0  ${Length}
  #\                           Log  ${ListOfPages[${i}]}
  \                          ${Output}=  Run  curl -s -H "Content-Type: text/html; charset=utf-8" --data-binary @${STUDENT}/${ListOfPages[${i}]} https://validator.w3.org/nu/?out=xml
  \                          Create File  result${i}.xml  content=${Output}  encoding=UTF-8
  \                          ${TestResult}  Run Keyword And Ignore Error  XML.Element Should Not Exist  ${Output}  error  A következő oldal nem valid: ${ListOfPages[${i}]}
  \                          Log  Validation the following page: ${ListOfPages[${i}]} ${TestResult[0]}  level=WARN
  #[Return]                   ${Output}

Get All Subpages
   [Arguments]              ${Student}
   Open Browser And Navigate To Site  ${Student}/index.html
   ${NumberOfMenuItems}=      Get Matching Xpath Count  ${MenuContainer}
   ${NumberOfMenuItems}=      Convert To Integer    ${NumberOfMenuItems}
   ${IsAtLeast4PagesStatus}=  Run Keyword And Ignore Error  Should Be True    ${NumberOfMenuItems}>4
   Log                        Is the page has at least 4 pages: ${IsAtLeast4PagesStatus[0]}  level=WARN
   ${NumberOfMenuItems}       Set Variable  ${NumberOfMenuItems+1}
   ${ListOfPages}=            Create List
   #${TestResult}=             Selenium2Library.Get Element Attribute  ${MenuContainer}[1]/a@href
   : FOR                      ${i}  IN RANGE  1  ${NumberOfMenuItems}
   \                          ${SubPages}=  Selenium2Library.Get Element Attribute  ${MenuContainer}[${i}]/a@href
   \                          ${First}  ${Last}=  Split String From Right  ${SubPages}  /  1
   \                          Append To List    ${ListOfPages}    ${Last}
   #\                          Log  ${Last}  level=WARN
   [Return]                   ${ListOfPages}
