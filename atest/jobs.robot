*** Settings ***
Library    JenkinsLibrary
Suite Setup    Set Jenkins Server    url=http://127.0.0.1:8080    username=admin    password=admin

*** Variables ***
${test_job_name}    test_job

*** Test Cases ***
Get One Existent Job
    [Tags]    job
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Get Jenkins Job By Name    ${test_job_name}

Create Existed Job
    [Tags]    job
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Run Keyword And Expect Error    Specified job already exists: ${test_job_name}\
    ...    Create Jenkins Job    ${test_job_name}

Delete Inexistent Job
    [Tags]    job
    Run Keyword And Expect Error    There is no specified job in Jenkins: ${test_job_name}\
    ...    Delete Jenkins Job    ${test_job_name}
