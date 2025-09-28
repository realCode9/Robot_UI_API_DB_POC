*** Settings ***
Library    SeleniumLibrary
Library    ../CustomPyLibraries/FirstClass.py
Suite Teardown    Close All Browsers

*** Variables ***
${url}    https://rahulshettyacademy.com/angularpractice/shop
${cssItemsArea}    xpath://img[@src='assets/img/iphonex.jpg']
${cssElementTexts}    css:.card-title
@{productsList}    iphone X    Nokia Edge

*** Test Cases ***
Use First Custom Keyword
#    First Def Keyword
    First Custom Keyword
    Open Browser And Hit Url    ${url}
    Sleep    5s
    Scroll Into View For The Element    ${cssItemsArea}
    Select Item To Add To Cart    ${cssElementTexts}      ${productsList}
#    Verify Added Item Count In The Cart
    Sleep    10s
    

*** Keywords ***
Open Browser And Hit Url
    [Arguments]    ${url}
    Open Browser    ${url}    chrome
    
Scroll Into View For The Element
    [Arguments]    ${element}
    Scroll Element Into View    ${element}