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
Check Semating Coding
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}

Check Pages Title Tag
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${PageTitle}=  Get Title
    \                          Should Not Be Empty  ${PageTitle}
    \                          ${PageHaseCorrectTitles}=  Run Keyword And Ignore Error  Should Match  ${PageTitle}  *-*
    Log                        Is the page has correct <title> tags: ${PageHaseCorrectTitles[0]}  level=WARN


Check Html 5 Tags
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}
    ${ResultHeaderTag}=        Set Variable  0
    ${ResultNavTag}=           Set Variable  0
    ${ResultSectionTag}=       Set Variable  0
    ${ResultArticleTag}=       Set Variable  0
    ${ResultAsideTag}=         Set Variable  0
    ${ResultFooterTag}=        Set Variable  0
    ${ResultFigureTag}=        Set Variable  0
    ${ResultVideoTag}=         Set Variable  0
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/${ListOfPages[${i}]}
    \                          ${CurrentCountHeader}  Get Count  ${CurrentFile}  <header
    \                          ${CurrentCountNav}  Get Count  ${CurrentFile}  <nav
    \                          ${CurrentCountSection}  Get Count  ${CurrentFile}  <section
    \                          ${CurrentCountArticle}  Get Count  ${CurrentFile}  <article
    \                          ${CurrentCountAside}  Get Count  ${CurrentFile}  <asdie
    \                          ${CurrentCountFooter}  Get Count  ${CurrentFile}  <footer
    \                          ${CurrentCountFigure}  Get Count  ${CurrentFile}  <figure
    \                          ${CurrentCountVideo}  Get Count  ${CurrentFile}  <video
    \                          ${ResultHeaderTag}=  Evaluate    ${ResultHeaderTag}+${CurrentCountHeader}
    \                          ${ResultNavTag}=  Evaluate    ${ResultNavTag}+${CurrentCountNav}
    \                          ${ResultSectionTag}=  Evaluate    ${ResultSectionTag}+${CurrentCountSection}
    \                          ${ResultArticleTag}=  Evaluate    ${ResultArticleTag}+${CurrentCountArticle}
    \                          ${ResultAsideTag}=  Evaluate    ${ResultAsideTag}+${CurrentCountAside}
    \                          ${ResultFooterTag}=  Evaluate    ${ResultFooterTag}+${CurrentCountFooter}
    \                          ${ResultFigureTag}=  Evaluate    ${ResultFigureTag}+${CurrentCountFigure}
    \                          ${ResultVideoTag}=  Evaluate    ${ResultVideoTag}+${CurrentCountVideo}
    ${IsThereHeaderTag}=       Run Keyword And Ignore Error  Should Be True    ${ResultHeaderTag}>0
    ${IsThereNavTag}=          Run Keyword And Ignore Error  Should Be True    ${ResultNavTag}>0
    ${IsThereSectionTag}=      Run Keyword And Ignore Error  Should Be True    ${ResultSectionTag}>0
    ${IsThereArticleTag}=      Run Keyword And Ignore Error  Should Be True    ${ResultArticleTag}>0
    ${IsThereAsideTag}=        Run Keyword And Ignore Error  Should Be True    ${ResultAsideTag}>0
    ${IsThereFooterTag}=       Run Keyword And Ignore Error  Should Be True    ${ResultFooterTag}>0
    ${IsThereFigureTag}=       Run Keyword And Ignore Error  Should Be True    ${ResultFigureTag}>0
    ${IsThereVideoTag}=        Run Keyword And Ignore Error  Should Be True    ${ResultVideoTag}>0
    Log                        Is the page has <header> tag: ${IsThereHeaderTag[0]}  level=WARN
    Log                        Is the page has <nav> tag: ${IsThereNavTag[0]}  level=WARN
    Log                        Is the page has <section> tag: ${IsThereSectionTag[0]}  level=WARN
    Log                        Is the page has <article> tag: ${IsThereArticleTag[0]}  level=WARN
    Log                        Is the page has <aside> tag: ${IsThereAsideTag[0]}  level=WARN
    Log                        Is the page has <footer> tag: ${IsThereFooterTag[0]}  level=WARN
    Log                        Is the page has <figure> tag: ${IsThereFigureTag[0]}  level=WARN
    Log                        Is the page has <video> tag: ${IsThereVideoTag[0]}  level=WARN


Check If The Page Has At Least 3 External Links
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}
    ${ResultExternalLinks1}=    Set Variable  0
    ${ResultExternalLinks2}=    Set Variable  0
    ${ResultExternalLinks}=    Set Variable  0
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/${ListOfPages[${i}]}
    \                          ${CurrentCountExternalLinks1}  Get Count  ${CurrentFile}  http://
    \                          ${CurrentCountExternalLinks2}  Get Count  ${CurrentFile}  https://
    \                          ${ResultExternalLinks1}=  Evaluate    ${ResultExternalLinks1}+${CurrentCountExternalLinks1}
    \                          ${ResultExternalLinks2}=  Evaluate    ${ResultExternalLinks2}+${CurrentCountExternalLinks2}
    \                          ${ResultExternalLinks}=  Evaluate    ${ResultExternalLinks1}+${ResultExternalLinks2}
    ${IsThereAtLeastThreeExternalLink}=  Run Keyword And Ignore Error  Should Be True    ${ResultExternalLinks}>2
    Log                        Is the page has at least 3 external links: ${IsThereAtLeastThreeExternalLink[0]}  level=WARN


Check If Submit Form Is Properly Used
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}
    ${ResultForms}=             Set Variable  0
    ${ResultInputs}=            Set Variable  0
    ${ResultOptions}=           Set Variable  0
    ${ResultDropwdowns}=        Set Variable  0
    ${ResultCheckBox}=          Set Variable  0
    ${ResultSubmitButton}=      Set Variable  0
    ${ResultResetButton}=      Set Variable  0
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/${ListOfPages[${i}]}
    \                          ${CurrentCountForms}  Get Count  ${CurrentFile}  <form
    \                          ${CurrentCountInputs}  Get Count  ${CurrentFile}  <input type="text"
    \                          ${CurrentCountOptions}  Get Count  ${CurrentFile}  <input type="radio"
    \                          ${CurrentCountDropwdown}  Get Count  ${CurrentFile}  <select
    \                          ${CurrentCountCheckbox}  Get Count  ${CurrentFile}  <input type="checkbox"
    \                          ${CurrentCountSubmitButton}  Get Count  ${CurrentFile}  type="submit"
    \                          ${CurrentCountResetButton}  Get Count  ${CurrentFile}  type="reset"
    \                          ${ResultForms}=  Evaluate    ${ResultForms}+${CurrentCountForms}
    \                          ${ResultInputs}=  Evaluate    ${ResultInputs}+${CurrentCountInputs}
    \                          ${ResultOptions}=  Evaluate    ${ResultOptions}+${CurrentCountOptions}
    \                          ${ResultDropwdowns}=  Evaluate    ${ResultDropwdowns}+${CurrentCountDropwdown}
    \                          ${ResultCheckBox}=  Evaluate    ${ResultCheckBox}+${CurrentCountCheckbox}
    \                          ${ResultSubmitButton}=  Evaluate    ${ResultSubmitButton}+${CurrentCountSubmitButton}
    \                          ${ResultResetButton}=  Evaluate    ${ResultResetButton}+${CurrentCountResetButton}
    ${IsThereAtLeastOneForm}=  Run Keyword And Ignore Error  Should Be True    ${ResultForms}>0
    ${IsThereAtLeastOneInput}=  Run Keyword And Ignore Error  Should Be True    ${ResultInputs}>0
    ${IsThereAtLeastTwoOptions}=  Run Keyword And Ignore Error  Should Be True    ${ResultOptions}>1
    ${IsThereAtLeastOneDropdown}=  Run Keyword And Ignore Error  Should Be True    ${ResultDropwdowns}>0
    ${IsThereAtLeastOneCheckbox}=  Run Keyword And Ignore Error  Should Be True    ${ResultCheckBox}>0
    ${IsThereAtLeastOneSubmitButton}=  Run Keyword And Ignore Error  Should Be True    ${ResultSubmitButton}>0
    ${IsThereAtLeastOneResetButton}=  Run Keyword And Ignore Error  Should Be True    ${ResultResetButton}>0
    Log                        Is the page has at least 1 form: ${IsThereAtLeastOneForm[0]}  level=WARN
    Log                        Is the page has at least 1 input: ${IsThereAtLeastOneInput[0]}  level=WARN
    Log                        Is the page has at least 2 options: ${IsThereAtLeastTwoOptions[0]}  level=WARN
    Log                        Is the page has at least 1 dropdown: ${IsThereAtLeastOneDropdown[0]}  level=WARN
    Log                        Is the page has at least 1 checknox: ${IsThereAtLeastOneCheckbox[0]}  level=WARN
    Log                        Is the page has at least 1 submit button: ${IsThereAtLeastOneSubmitButton[0]}  level=WARN
    Log                        Is the page has at least 1 reset button: ${IsThereAtLeastOneResetButton[0]}  level=WARN


Check If Tables Are Properly Used
    [Arguments]                ${ListOfPages}
    ${Length}=                 Get Length  ${ListOfPages}
    ${ResultDetails}=          Set Variable    0
    ${ResultSummary}=          Set Variable    0
    ${ResultCaption}=          Set Variable    0
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/${ListOfPages[${i}]}
    \                          ${CurrentCountDetails}  Get Count  ${CurrentFile}  <details
    \                          ${CurrentCountSummary}  Get Count  ${CurrentFile}  <summary
    \                          ${CurrentCountCaption}  Get Count  ${CurrentFile}  <caption
    \                          ${ResultDetails}=  Evaluate    ${ResultDetails}+${CurrentCountDetails}
    \                          ${ResultSummary}=  Evaluate    ${ResultSummary}+${CurrentCountSummary}
    \                          ${ResultCaption}=  Evaluate    ${ResultCaption}+${CurrentCountCaption}
    ${IsDetailsTagVisibleResult}=  Run Keyword And Ignore Error  Should Be True    ${ResultDetails}>0
    ${IsSummaryTagVisibleResult}=  Run Keyword And Ignore Error  Should Be True    ${ResultSummary}>0
    ${IsCaptionTagVisibleResult}=  Run Keyword And Ignore Error  Should Be True    ${ResultCaption}>0
    Log                        Is the page has at least 1 details tag: ${IsDetailsTagVisibleResult[0]}  level=WARN
    Log                        Is the page has at least 1 summary tag: ${IsSummaryTagVisibleResult[0]}  level=WARN
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
   ${IsAllOk}=                 Set Variable If    '${TestResult[0]}'=='FAIL'  FAIL  ${EMPTY}
   Set Test Variable           ${IsAllOk}    ${IsAllOk}
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
  \                          ${TestResult}  Run Keyword And Ignore Error  XML.Element Should Not Exist  ${Output}  error
  \                          ${IsAllOk}=  Set Variable If    '${TestResult[0]}'=='FAIL'  FAIL  ${EMPTY}
  \                          Log  Validation the following page: ${ListOfPages[${i}]} ${TestResult[0]}  level=WARN
  Set Test Variable          ${IsAllOk}    ${IsAllOk}
  [Return]                   ${IsAllOk}

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

Check If There Is Any Fails
    [Arguments]               ${TestScopeVariable}
    Should Be Empty           ${TestScopeVariable}  Az oldal nem felel meg minden szempontnak!

Check If CSS Has Proper Font Settings
   [Arguments]                ${Student}
   ${CssFiles}=               OperatingSystem.List Files In Directory    ${Student}/style/    *.css    absolute=False
   ${Length}=                 Get Length  ${CssFiles}
   #${Length}=                 Convert To Integer    ${Length}
   : FOR                      ${i}  IN RANGE  0  ${Length}
   #\                          Log  ${CssFiles[${i}]}  level=WARN
   \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/style/${CssFiles[${i}]}
   \                          ${Group1} =
   \                          ...  BuiltIn.Should Match Regexp  ${CurrentFile}  ${CssFontFamilyRegexp}
   \                          ${Group2} =
   \                          ...  BuiltIn.Should Not Match Regexp  ${CurrentFile}  ${CssFontSizeRegexp}
   #\                          Log  Check If Page Contains Background Image: ${CssFiles[${i}]} ${TestResult[0]}  level=WARN
   ${ResultFontSize}=          Set Variable If    '${Group2}'=='None'  PASS  FAIL
   ${ResultFontFamilyLength}=  Get Length    ${Group1}
   ${ResultFontFamily}=       Run Keyword And Ignore Error  Should Be True    '${ResultFontFamilyLength}'>1

   Log                        Check If Page Has Proper font-size Declaration ${ResultFontSize}  level=WARN
   Log                        Check If Page Has Proper font-family Declaration ${ResultFontFamily[0]}  level=WARN

Verify There Is No Frame On The Site
  [Arguments]                ${ListOfPages}
  ${Length}=                 Get Length  ${ListOfPages}
  ${ResultFrames}=          Set Variable    0
    : FOR                      ${i}  IN RANGE  0  ${Length}
    #\                           Log  ${ListOfPages[${i}]}  level=WARN
    \                          ${CurrentFile}=  OperatingSystem.Get File  ${Student}/${ListOfPages[${i}]}
    \                          ${CurrentCountFrames}  Get Count  ${CurrentFile}  <frame
    \                          ${ResultFrames}=  Evaluate    ${ResultFrames}+${CurrentCountFrames}
    ${ResultFrames}=           Convert To Integer    ${ResultFrames}
    ${IsThePageContainsFrames}=  Run Keyword And Ignore Error  Should Be Equal As Integers  ${ResultFrames}  0
    Log                        Verify the page does not contain frames: ${IsThePageContainsFrames[0]}  level=WARN
