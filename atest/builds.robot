*** Settings ***
Library    JenkinsLibrary
Resource    lib/jenkins_keywords.robot
Suite Setup    Set Jenkins Server    url=${jenkins_address}    username=admin    password=admin

*** Variables ***
${test_job_name}    test_job

*** Test Cases ***
Get Builds (inexistent job)
    [Tags]    job    build
    Run Keyword And Expect Error    There is no specified job in Jenkins: ${test_job_name}\
    ...    Get Jenkins Job Builds    ${test_job_name}

Get Builds (existent jobs, multiple builds)
    [Tags]    job    build
    [Setup]    Create Job And Run Multiple Builds
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${builds} =    Get Jenkins Job Builds    ${test_job_name}
    Should Be True    ${builds}
    Should Be Equal As Integers    1    ${builds['builds'][2]['number']}
    Should Be Equal As Integers    2    ${builds['builds'][1]['number']}
    Should Be Equal As Integers    3    ${builds['builds'][0]['number']}

Get Builds (existent jobs, no builds)
    [Tags]    job    build
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${builds} =    Get Jenkins Job Builds    ${test_job_name}
    Should Not Be True    ${builds['lastBuild']}
    Should Be Equal As Integers    1    ${builds['nextBuildNumber']}
