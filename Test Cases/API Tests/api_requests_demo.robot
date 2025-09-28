*** Settings ***
Documentation    This suite describes test cases around book library.
...            Covers create book, get book and delete book.
Resource    ../../Resources/API_Resources/setup_requests.resource

*** Test Cases ***
Verify Writing Post Request
    [Documentation]    This test verifies book creation using post request.
    [Tags]    create-book
    ${bookInfo}    Create Book Post Request
    Log    Created Book Details:${bookInfo}

Verify Writing Get Request
    [Documentation]    This test verifies created book can be get using get request.
    ...    Also verifies isbn number of the book created with get request isbn number.
    [Tags]    get-book    robot:skip
    ${bookInfo}    Create Book Post Request
    ${getBookInfo}    Get Book Details Request    ${bookInfo}[createBookResponse][ID]
    Should Be Equal As Strings    ${bookInfo}[isbn]    ${getBookInfo}[0][isbn]

Verify Writing Delete Request
    [Documentation]    This test verifies created book is deleted successfully
    [Tags]    delete-book    robot:skip
    ${bookInfo}    Create Book Post Request
    ${deleteBookMessage}    Delete Book Request    ${bookInfo}[createBookResponse][ID]
    Log    Delete book message:${deleteBookMessage}
    Should Be Equal As Strings    ${deleteBookMessage}[0]    book is successfully deleted