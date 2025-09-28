*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary

*** Test Cases ***
handle simple alert selenium
    Open Browser    https://demo.automationtesting.in/Alerts.html    chrome
    Wait Until Element Is Visible    //button[@onclick='alertbox()']
    Click Button    //button[@onclick='alertbox()']
    ${message}    Handle Alert    LEAVE
    Log    Alert message: ${message}
    Sleep    10s
    Close Browser

Takes Screenshot
    Open Browser    https://demo.automationtesting.in/Alerts.html    chrome
    Wait Until Element Is Visible    //button[@onclick='alertbox()']
    Capture Element Screenshot    //button[@onclick='alertbox()']    ${OUTPUTDIR}/id_image_id-1.png
#    Alert Should Be Present    I am an alert box!    #By default alert is accepted if action is not given
    Close Browser

API
    GET
    POST
