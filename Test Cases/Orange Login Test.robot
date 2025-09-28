*** Settings ***
Library    RequestsLibrary
Resource    ../Resources/UIResources/LoginPage.resource
Variables    ../TestData/LoginTestData.py
Suite Teardown    Close All Browsers

*** Test Cases ***
Verify Orange Unsuccessful Login With Invalid Credentials
    Verify Invalid Login Attempt With Invalid Creds Message    ${invalidUsername}    ${invalidPassword}
    Verify Invalid Login Attempt With Invalid Creds Message    ${validUsername}      ${invalidPassword}
    Verify Invalid Login Attempt With Invalid Creds Message    ${invalidUsername}    ${validPassword}

Verify Orange Successful Login With Valid Credentials
    Verify Valid Login Attempt And User Lands On Dashboard Page    ${validUsername}    ${validPassword}

Verify Forgot Password Functionality Sends Link To Mail Id
    [Tags]    forgotPassword
    Navigate To Forgot Password Page And Send Mail To Reset Password    ${validUsername}

Verify Navigation To Orange HRM Social Media Pages
    [Tags]    socialMedia
    Verify Navigate To Social Media Page And Page Title    ${xpathLinkedInSocialMediaPage}    ${linkedInTitle}
    Verify Navigate To Social Media Page And Page Title    ${xpathFacebookSocialMediaPage}    ${facebookTitle}
    Verify Navigate To Social Media Page And Page Title    ${xpathXSocialMediaPage}    ${xTitle}
    Verify Navigate To Social Media Page And Page Title    ${xpathYoutubeSocialMediaPage}    ${youtubeTitle}

Verify Login With User Credentials Displayed On Login Page
    [Tags]    userCreds
    ${credsFromUI}    Get User Creds From Orange HRM Login Page And Use It For Application Login
    Verify Valid Login Attempt And User Lands On Dashboard Page    ${credsFromUI}[usernameUI]    ${credsFromUI}[passwordUI]

Verify Post API Call
    POST
    POST On Session
    Post Request        
