*** Settings ***
Documentation  Methods to prepare standart situation to start test and cleanup method for end of test.
Resource       utils.resource

*** Keywords ***

URL check
    ${Web_URL}  Get Location
    View in log  [I][URL] Compare : [w] "${Web_URL}" == "${URL}"
    Should be equal  ${Web_URL}  ${URL}

Setup test suite
    Open page
    Set selenium settings
    Maximize browser window

Open page
    IF  "${BROWSER}" == "chrome"
        Set chrome option
    ELSE
        Open browser  ${URL}  ${BROWSER}
    END

Set selenium settings
    Set Selenium Timeout	${orig timeout}
    Set Selenium Speed	    ${selenium speed}

Set chrome option
    ${ChromeOptions}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    IF  ${HEADLESS}
        Call Method  ${ChromeOptions}   add_argument  --headless
        Call Method  ${ChromeOptions}   add_argument  --no-sandbox
    END

    ${Options}=  Call Method     ${ChromeOptions}   to_capabilities
    Open browser  ${URL}  ${BROWSER}  desired_capabilities=${Options}
    Set window size  1680  1200

End test
    close browser
