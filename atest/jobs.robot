*** Settings ***
Library    Collections
Library    JenkinsLibrary
Suite Setup    Set Jenkins Server    url=http://127.0.0.1:8080    username=admin    password=admin

*** Variables ***
${test_job_name}    test_job
${second_test_job_name}    blablabla_job

*** Test Cases ***
Get One Existent Job
    [Tags]    job
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${job} =    Get Jenkins Job By Name    ${test_job_name}
    Should Be True    ${job}

Get Inexistent Job
    [Tags]    job
    Run Keyword And Expect Error    Can't find specified job: ${test_job_name}\
    ...    Get Jenkins Job By Name    ${test_job_name}

Get Jobs (empty Jenkins)
    [Tags]    job
    ${jobs} =    Get Jenkins Jobs
    Should Not Be True    ${jobs}

Get Jobs (multiple jobs)
    [Tags]    job
    [Setup]    Create Multiple Jobs
    [Teardown]    Delete Multiple Jobs
    Check Multiple Jobs

Create Existent Job
    [Tags]    job
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Run Keyword And Expect Error    Specified job already exists: ${test_job_name}\
    ...    Create Jenkins Job    ${test_job_name}

Delete Inexistent Job
    [Tags]    job
    Run Keyword And Expect Error    There is no specified job in Jenkins: ${test_job_name}\
    ...    Delete Jenkins Job    ${test_job_name}


*** Keywords ***
Create Multiple Jobs
    Create Jenkins Job    ${test_job_name}
    Create Jenkins Job    ${second_test_job_name}

Delete Multiple Jobs
    Delete Jenkins Job    ${test_job_name}
    Delete Jenkins Job    ${second_test_job_name}

Check Multiple Jobs
    ${jobs} =    Get Jenkins Jobs
    Should Be True    ${jobs}
    ${second_job} =    Get From List    ${jobs}    0
    Should Be Equal    ${second_job['name']}    ${second_test_job_name}
    Should Be Equal    ${second_job['url']}    http://127.0.0.1:8080/job/${second_test_job_name}/
    ${first_job} =    Get From List    ${jobs}    1
    Should Be Equal    ${first_job['name']}    ${test_job_name}
    Should Be Equal    ${first_job['url']}    http://127.0.0.1:8080/job/${test_job_name}/
