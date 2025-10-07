*** Settings ***
Library    DatabaseLibrary
Library    Collections
Variables    ../../TestData/GlobalTestData.py

*** Keywords ***
Connect To SQL DB
    [Documentation]    This keyword connect to db based on environment specific -
    ...    connection url, username and password.
    Set Log Level    NONE
    ${databaseInfo}    Get Database Url, Username And Password
    Wait Until Keyword Succeeds    ${implicitWaitTime}    3s    Connect To Database    pymysql    ${databaseInfo}[db_name]    ${databaseInfo}[db_username]    ${databaseInfo}[db_password]    ${databaseInfo}[db_url]    3306
    Set Log Level    INFO

Get Database Url, Username And Password
    [Documentation]    Parses database information from global variable test data file.
    ...    Returns dictionary containing db name, url, username and password.
    ${databaseInfo}    Create Dictionary
    Set To Dictionary    ${databaseInfo}    db_name    ${db_name}
    Set To Dictionary    ${databaseInfo}    db_url    ${db_url}
    Set To Dictionary    ${databaseInfo}    db_username    ${db_username}
    Set To Dictionary    ${databaseInfo}    db_password    ${db_password}
    RETURN    ${databaseInfo}