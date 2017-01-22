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

*** Variables ***


*** Keywords ***

Validate One Individual Page
  [Arguments]                ${Page}
  ${Output}=                 Run  curl -s -H "Content-Type: text/html; charset=utf-8" --data-binary @log.html https://validator.w3.org/nu/?out=xml
  Create File                result.xml  content=${Output}  encoding=UTF-8
  ${Messages}                XML.Element Should Not Exist  ${Output}  error  A feltöltött oldal nem valid!
  [Return]                   ${Output}
