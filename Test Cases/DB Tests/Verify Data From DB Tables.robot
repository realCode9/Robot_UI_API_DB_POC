*** Settings ***
Documentation    This test suite connect to sample db with basic details and verifies -
...              Db Connection, data validations, different sql queries.
Library           DatabaseLibrary    log_query_results=True
Suite Setup       Connect To SQL DB
Suite Teardown    Disconnect From Database
Resource          ../../Resources/DB_Resources/db_keywords.resource

*** Test Cases ***
Verify Data From Products Table
    [Documentation]    This test verifies different scenarios around db validations.
    ...    ***Various keywords***
    ...    Row count - This keyword get row count of select_statement and can be verified with expected count with assertion operator
    ...    
    [Tags]    db-test
    ${productInfoDB}    Query    SELECT * FROM products WHERE productline='Motorcycles'
    Log    Product Info From DB:${productInfoDB}
    ${rowCount}    Row Count    SELECT * FROM products WHERE productline='Motorcycles'
    Log    row count:${rowCount}
    #Check row count    select_statement    assertion_operator    expected_value
    Check Row Count    SELECT * FROM products WHERE productline='Motorcycles'    ==    13
    Check Query Result    SELECT productVendor FROM products where productCode='S10_1949'    contains    Classic Metal Creations
    ${productTableDesc}    Description    SELECT * FROM products WHERE productline='Motorcycles'
    Log    Product Table Description:${productTableDesc}

Verify Data From Database With Parameters List As Table Names
    [Documentation]    This test verifies database data with list of parameters of table names.
    [Tags]    db-test
    @{parameters}	Create List    products
    ${multiTableData}    Query    SELECT * FROM products
    Log    Multi table data from database:${multiTableData}
    Check Row Count    SELECT * FROM products WHERE productline='Motorcycles11'    ==    0
    Row Count Is 0    SELECT * FROM products WHERE productline='Cars24'    #Deprecated keyword instead use Check Row Count
    Table Must Exist    employees
    Table Must Exist    products

