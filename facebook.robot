*** Settings ***
Library    SeleniumLibrary

*** Variable ***
${EMAIL}    xxxx@hotmail.com
${PASSWORD}     xxxx

*** Test Case ***
Post Comment On Facebook
    Open facebook page
    Post Comment     ${EMAIL}    ${PASSWORD}

*** Keywords ***
Open facebook page
    Set Chrome Disable Notifications
    Go To    https://www.facebook.com/

Set Chrome Disable Notifications
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --disable-notifications
    Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=/usr/local/bin/chromedriver
    [Return]    ${chrome_options}

Post Comment
    [Arguments]     ${EMAIL}    ${PASSWORD}
    Sign In With Credential     ${EMAIL}    ${PASSWORD}
    Wait Until Element Is Visible   pagelet_megaphone
    Click Link      xpath=//*/div[@id="feedx_sprouts_container"]//*/a[@data-attachment-type="STATUS"]
    Wait Until Element Is Visible   //*/table[@role="presentation"]
    Press Key       xpath=//*/div[@id="feedx_sprouts_container"]//div[@data-testid="status-attachment-mentions-input"]    Robot Framework
    Click Button    xpath=//*/button[@data-testid="react-composer-post-button"]

Sign In With Credential
    [Arguments]     ${EMAIL}    ${PASSWORD}
    Input Text    email    ${EMAIL}
    Input Password    pass    ${PASSWORD}
    Click Button     xpath=//*[@id="loginbutton"]/input 