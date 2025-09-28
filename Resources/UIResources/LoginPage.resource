*** Settings ***
Library        SeleniumLibrary
Library        String
Resource       DashboardPage.resource
Variables      ../../TestData/LoginTestData.py

*** Variables ***
${implicitlyWaitTime}    30s
${url}                  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${xpathUsername}        xpath://input[@placeholder='Username']
${xpathPassword}        xpath://input[@placeholder='Password']
${xpathLoginButton}     css:.oxd-button
${xpathInvalidCreds}    css:.oxd-alert-content-text
${cssForgotPassword}    css:.orangehrm-login-forgot-header
${xpathResetPasswordHeader}    xpath://h6[normalize-space()='Reset Password']
${cssResetPasswordBtn}    css:button[type='submit']
${resetPasswordSuccessMsg}    //h6[normalize-space()='Reset Password link sent successfully']
${xpathLinkedInSocialMediaPage}    (//*[local-name()='svg'])[1]
${xpathFacebookSocialMediaPage}    (//*[local-name()='svg'])[2]
${xpathXSocialMediaPage}    (//*[local-name()='svg'])[3]
${xpathYoutubeSocialMediaPage}    (//*[local-name()='svg'])[4]
${xpathDisplayedUsername}    //p[normalize-space()='Username : Admin']
${xpathDisplayedPassword}    //p[normalize-space()='Password : admin123']


*** Keywords ***
Open Browser And Login To Application
    [Arguments]    ${usernameValue}    ${passwordValue}
    [Documentation]    This keyword will open the browser and login to application.
    ...    **Arguments**
    ...    ${url}= Url to the application.
    ...    ${xpathUsername}, ${xpathPassword}= Locator address for username and password field.
    ...    ${usernameValue}, ${passwordValue}= Username and Password values to be entered to login.
    Open Browser       ${url}             chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${xpathUsername}    ${implicitlyWaitTime}
    Wait Until Element Is Visible    ${xpathPassword}    ${implicitlyWaitTime}
    Wait Until Element Is Visible    ${xpathLoginButton}    ${implicitlyWaitTime}
    Input Text        ${xpathUsername}    ${usernameValue}
    Input Password    ${xpathPassword}    ${passwordValue}
    Click Button      ${xpathLoginButton}

Verify Invalid Login Attempt With Invalid Creds Message
    [Arguments]    ${usernameValue}    ${passwordValue}
    [Documentation]    This keyword verifies login to orange application with invalid combination of login creds.
    ...    ${usernameValue}, ${passwordValue}= Either of it or both should be invalid to validate invalid login attempt.
    Open Browser And Login To Application    ${usernameValue}    ${passwordValue}
    Wait Until Element Is Visible    ${xpathInvalidCreds}
    Element Text Should Be    ${xpathInvalidCreds}    ${invalidCredsErrMsg}
    Close Browser

Verify Valid Login Attempt And User Lands On Dashboard Page
    [Arguments]    ${usernameValue}    ${passwordValue}
    [Documentation]    This keyword takes valid username and password values to validate successful login attempt.
    ...    Also verify after login lands on dashboard page.
    ...    ${usernameValue}, ${passwordValue}= Take valid values to validate successful attempt.
    Open Browser And Login To Application    ${usernameValue}    ${passwordValue}
    Wait Until Element Is Visible    ${xpathDashboardHeader}
    Element Text Should Be    ${xpathDashboardHeader}    Dashboard
    Close Browser

Navigate To Forgot Password Page And Send Mail To Reset Password
    [Arguments]    ${usernameValue}
    [Documentation]    This keyword ensure forget password password function successfully send resent password link to mail.
    Open Browser       ${url}             chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${cssForgotPassword}
    Click Element    ${cssForgotPassword}
    Wait Until Element Is Visible    ${xpathResetPasswordHeader}
    Input Text    ${xpathUsername}    ${usernameValue}
    Click Element    ${cssResetPasswordBtn}
    Wait Until Element Is Visible    ${resetPasswordSuccessMsg}
    Element Text Should Be    ${resetPasswordSuccessMsg}    Reset Password link sent successfully
    Close Browser

Verify Navigate To Social Media Page And Page Title
    [Arguments]    ${xpathSocialMediaPage}    ${titleName}
    [Documentation]    This keyword make sure navigate social media page and validate respective page title.
    Open Browser       ${url}             chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${xpathSocialMediaPage}
    Click Element    ${xpathSocialMediaPage}
#    Click Link
    Switch Window    NEW    ${implicitlyWaitTime}
    ${pageTitle}=    Get Title
    Log    Page title is:${pageTitle}
    Sleep    5s
    Title Should Be    ${titleName}
    Close Browser

Get User Creds From Orange HRM Login Page And Use It For Application Login
    Open Browser       ${url}             chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${xpathDisplayedUsername}
    ${usernameText}    Get Text    ${xpathDisplayedUsername}
    ${passwordText}    Get Text    ${xpathDisplayedPassword}
    @{splitUsernameString}    Split String    ${usernameText}
    @{splitPasswordString}    Split String    ${passwordText}
    Log    ${splitUsernameString}[2]
    ${credsFromUI}    Create Dictionary    usernameUI=${splitUsernameString}[2]    passwordUI=${splitPasswordString}[2]
    Close Browser
    RETURN    ${credsFromUI}