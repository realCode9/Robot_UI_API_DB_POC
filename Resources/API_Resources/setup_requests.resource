*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    String
Library    JSONLibrary
Variables    apiEndpoints.py

*** Variables ***
${base_url}    https://216.10.245.166
${create_book_json}    ../RobotPOC/API Test Payload/addBook.json
${delete_book_json}    ../RobotPOC/API Test Payload/deleteBook.json

*** Keywords ***
Create Test API Session
    [Documentation]    This keyword create api session using headers, base url with connection timeout of 30s
    ${sessionAlias}=    Set Variable    apiTestSession
    Create Session    ${sessionAlias}    ${base_url}    timeout=30
    &{headers}    Create Dictionary    Content-Type=application/json    Accept=*/*
    Update Session    ${sessionAlias}    headers=${headers}
    RETURN    ${sessionAlias}

Create Book Post Request
    [Documentation]    This keyword create book in the library with post on session request.
    ${postRegisterJson}    Load Crate Book Json    ${create_book_json}
    ${sessionAlias}    Create Test API Session
    Log    Endpoint:${ADD_BOOK_ENDPOINT}
    Log    Json File For Post:${postRegisterJson}
    ${postResponse}    POST On Session    ${sessionAlias}    ${ADD_BOOK_ENDPOINT}    json=${postRegisterJson}
    Log    Post Req Response:${postResponse.json()}
    Should Not Be Empty    ${postResponse.json()}
    Status Should Be    200    ${postResponse}
    Log    Create Book Json Content:${postResponse.content}
    Log    Cookies Jar Of Server Send Back:${postResponse.cookies}
    Log    Create Book Response Headers:${postResponse.headers}
    Log    Create book history from response:${postResponse.history}
    Log    Create Book Post Response:${postResponse.json()}
    Log    Create Book Reason:${postResponse.reason}
    Log    Create Book With Ok:${postResponse.ok}        #Returns true if status code is less than 400
    Log    Create Book response url:${postResponse.url}
    ${bookInfo}    Create Dictionary    isbn=${postRegisterJson}[isbn]    createBookResponse=${postResponse.json()}
    RETURN    ${bookInfo}

Get Book Details Request
    [Arguments]    ${bookId}
    [Documentation]    This keyword get book details from library with get on session request.
    ${sessionAlias}    Create Test API Session
    &{queryParam}    Create Dictionary       ID=${bookId}
    ${getBook}    GET On Session    ${sessionAlias}    ${GET_BOOK_ENDPOINT}    params=${queryParam}
    Status Should Be    200    ${getBook}
    Log    Get Book Response:${getBook.json()}
    RETURN    ${getBook.json()}

Load Crate Book Json
    [Arguments]    ${createEmployeeJsonPath}
    [Documentation]    This keyword alter and load the request json to create book in the dictionary.
    ...    *Arguments*
    ...    ${createEmployeeJsonPath}= Request json path.
    ${randomString}    Generate Random String    2    [LOWER]
    ${randomNumber}    Generate Random String    3    [NUMBERS]
    ${randomNumAge}    Evaluate    random.randint(100, 200)    random
    ${strNumAge}    Convert To String    ${randomNumAge}
    ${req_json}    Get File    ${createEmployeeJsonPath}
    ${req_json}    Replace String    ${req_json}    __bookName__      Auto${randomString}
    ${req_json}    Replace String    ${req_json}    __isbnNumber__    ${randomString}
    ${req_json}    Replace String    ${req_json}    __aisle_           ${randomNumber}
    ${req_json}    Replace String    ${req_json}    __authorName__       Viru${randomString}
    ${json_body}    Convert String To Json    ${req_json}
    Log    Post Json:${json_body}
    RETURN    ${json_body}

Delete Book Request
    [Arguments]    ${bookId}
    [Documentation]    This keyword will delete book from the library.
    ...    *Arguments*
    ...    ${bookId}=Id of the book to be deleted.
    ${req_json}    Get File    ${delete_book_json}
    ${req_json}    Replace String    ${req_json}    __id__     ${bookId}
    ${req_json}    Convert String To Json    ${req_json}
    ${sessionAlias}    Create Test API Session
    ${deleteBookResponse}    POST On Session    ${sessionAlias}    ${DELETE_BOOK_ENDPOINT}    json=${req_json}
    Status Should Be    200    ${deleteBookResponse}
    ${deletedMessage}    Get Value From Json    ${deleteBookResponse.json()}    $.msg
    RETURN    ${deletedMessage}