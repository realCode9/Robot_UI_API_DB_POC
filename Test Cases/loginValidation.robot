*** Settings ***
Documentation    This suite verifies all scenarios related to login module.
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${xpathUsername}    //input[@placeholder='E mail']
${xpathPassword}    //input[@placeholder='Password']
${xpathEnterButton}    //body[@ng-app='Registerform']//div//a
${invalidUsername}    username12
${invalidPassword}    231231
${loginErrorMsg}    errormsg

*** Test Cases ***
Verify Unsuccessful Login
    [Documentation]    This test verify unsuccessful login attempt due to invalid creds and check error message.
    [Setup]    Setup And Open Browser
    Fill Login Form Details    ${xpathUsername}    ${xpathPassword}    ${xpathEnterButton}     ${invalidUsername}
    ...     ${invalidPassword}
    Wait For The Error Message Displayed    ${loginErrorMsg}
    Verify Login Error Message    ${loginErrorMsg}
    Close Browser

*** Keywords ***
Setup And Open Browser
    [Documentation]    This keyword setup the browser and open the browser.
    Open Browser    https://demo.automationtesting.in/SignIn.html    chrome

Fill Login Form Details
    [Arguments]    ${xpathUsername}    ${xpathPassword}    ${xpathEnterButton}    ${invalidUsername}   ${invalidPassword}
    [Documentation]    This keyword enter username, password and click enter button to login.
    ...    *Arguments*
    ...    ${xpathUsername}=xpath of username field
    ...    ${xpathPassword}=xpath of password field
    ...    ${xpathEnterButton}=xpath of enter button
    ...    ${invalidUsername},${invalidPassword}=username and password values to enter which is invalid to attempt unsuccessful login.
    Input Text    ${xpathUsername}       ${invalidUsername}
    Input Password    ${xpathPassword}    ${invalidPassword}
    Click Link    ${xpathEnterButton}
    
Wait For The Error Message Displayed
    [Arguments]    ${loginErrorMsg}
    [Documentation]    This keyword waits until error message displayed.
    Wait Until Element Is Visible    ${loginErrorMsg}
    
Verify Login Error Message
    [Arguments]    ${loginErrorMsg}
    [Documentation]    This keyword validates displayed login error message with expected login error message.
#    ${errorMsgText}    Get Text    ${loginErrorMsg}
#    Should Be Equal As Strings    ${errorMsgText}    Invalid User Name or PassWord
    Element Text Should Be    ${loginErrorMsg}    Invalid User Name or PassWord
