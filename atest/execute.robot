*** Settings ***
Library    Collections
Library    JenkinsLibrary
Suite Setup    Set Jenkins Server    url=http://127.0.0.1:8080    username=admin    password=admin

*** Variables ***
${test_job_name}    test_job

*** Test Cases ***
Wrong Params Type
    [Tags]    execute
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Run Keyword And Expect Error    Params must be a dictionary, not str\
    ...    Start Jenkins Job    ${test_job_name}    test_string

Run Existent Job Without Params
    [Tags]    execute
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Start Jenkins Job    ${test_job_name}

Run Inexistent Job
    [Tags]    execute
    Run Keyword And Expect Error    There is no specified job in Jenkins: ${test_job_name}\
    ...    Start Jenkins Job    ${test_job_name}


# TODO: Test with params, also add functionality for methods (params)
