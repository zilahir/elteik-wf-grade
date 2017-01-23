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

Resource                     variables.robot

*** Variables ***

${BROWSER}=       phantomjs

*** Keywords ***

Open Browser And Navigate To Site
   [Documentation]             Opens the desired browser with eir page, and logs in
   [Arguments]                 ${Url}
   Open Browser                ${Url}  ${BROWSER}
   #Set Window Size             1280  900
   Capture Page Screenshot

Validate One Individual Page
  [Arguments]                ${Page}
  ${Output}=                 Run  curl -s -H "Content-Type: text/html; charset=utf-8" --data-binary @${Page} https://validator.w3.org/nu/?out=xml
  Create File                result.xml  content=${Output}  encoding=UTF-8
  ${Messages}                XML.Element Should Not Exist  ${Output}  error  A feltöltött oldal nem valid!
  [Return]                   ${Output}

Get All Subpages
   [Arguments]              ${Student}
   Open Browser And Navigate To Site  ${Student}/index.html
   ${NumberOfMenuItems}=      Get Matching Xpath Count  ${MenuContainer}
   ${ListOfPages}=            Create List
   #${TestResult}=             Selenium2Library.Get Element Attribute  ${MenuContainer}[1]/a@href
   : FOR                      ${i}  IN RANGE  1  ${NumberOfMenuItems}
   \                          ${SubPages}=  Selenium2Library.Get Element Attribute  ${MenuContainer}[${i}]/a@href
   \                          Append To List    ${ListOfPages}    ${SubPages}
   [Return]                   ${ListOfPages}
