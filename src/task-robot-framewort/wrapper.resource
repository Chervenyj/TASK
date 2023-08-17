*** Settings ***
Resource   utils.resource

*** Keywords ***
Read data
    [Documentation]    First we use the json.load(open("${name}", encoding="utf-8")) function to load data from a file with the specified name.
    ...  We specify the encoding "utf-8" in order to correctly process the file with the symbols of the national alphabets.
    ...  Then we save the loaded data in the ${data} variable. Next, we use the set Variable command to create the ${data}View variable and assign it the value [I][DATA] ${data}.
    ...  This allows us to use this variable in the log to output the values of the ${data} variable.
    [Arguments]  ${name}
    ${data}  Evaluate  json.load(open("${name}", encoding="utf-8"))  json
    set suite Variable  ${data}
    View in log  [I][DATA] ${data}

Wait for element
    [Documentation]    Extends the basic keyword by waiting for the element to be ready and clicking on it.
    ...  Waits until the page: contains an element, the element is visible and enabled
    [Arguments]   ${locator}

    Wait until page contains element    ${locator}
    Wait Until Element Is Visible       ${locator}
    Wait Until Element Is Enabled       ${locator}

Click on element
    [Documentation]    Extends the basic keyword by waiting for the element to be ready and clicking on it.
    ...  Waits until the page: contains an element, the element is visible and enabled, and then clicks on it.
    [Arguments]    ${locator}   ${scroll}=${True}

    ${wait}  Run Keyword and Return Status  Wait for element  ${locator}
    IF  ${scroll}  Scroll Element Into View  ${locator}
    Wait for element    ${locator}
    ${status}  Run Keyword and Return Status  Click element  ${locator}
    IF  ${status} == False
        ${x}=        Get Horizontal Position  ${locator}
        ${y}=        Get Vertical Position    ${locator}
        Execute Javascript   document.querySelector('#main-section-container').scrollTo(${x+100}, ${y+100})    # if the Left/Right arrows interfere with the click
        Click element        ${locator}
    END

Check element text
    [Documentation]    Extends the basic keyword by waiting for the element to be ready and then verifying the text in the element.
    ...  Waits until the page: contains an element, the element is visible and enabled, and then verifies the text in the element.
    [Arguments]                 ${locator}  ${label_text}
    Wait for element            ${locator}
    View in log                 [I] Check : ${label_text}
    element text should be      ${locator}  ${label_text}

View in log
    [Documentation]    Keyword for comfortable debugging
    ...  User can use 0 for disable , 1 for Log to report, 2 for Log to console in settings resource
    [Arguments]  ${message}
    IF  ${LOG} == 1
        Log  ${message}
    ELSE IF  ${LOG} == 2
        Log to console  ${message}
    END

Reject all cookies

    Click on element    ${loc_BUTTON_REJECT_EVERYTHING}
