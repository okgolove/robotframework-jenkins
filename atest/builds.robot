*** Settings ***
Library    JenkinsLibrary
Resource    lib/jenkins_keywords.robot
Suite Setup    Set Jenkins Server    url=${jenkins_address}    username=admin    password=admin

*** Test Cases ***
# TODO: fix
# Get Builds (inexistent job)
#     [Tags]    job    build
#     Run Keyword And Expect Error    JenkinsException: job[${test_job_name}] does not exist\
#     ...    Get Jenkins Job Builds    ${test_job_name}

Get Builds (existent jobs, multiple builds)
    [Setup]    Create Job And Run Multiple Builds    ${test_job_name}    count=3
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${builds} =    Get Jenkins Job Builds    ${test_job_name}
    Should Be True    ${builds}
    Log    ${builds}
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

Check Finished Build Status 
    [Tags]    job    build
    [Setup]    Create Job From Template    ${test_job_name}    ${job_sleep}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${build_number} =    Start Jenkins Job    ${test_job_name}
    Wait Until Build Starts    ${test_job_name}    ${build_number}
    ${build_finished} =    Is Build Finished    ${test_job_name}    ${build_number}
    Should Not Be True    ${build_finished}

Check Running Build Status 
    [Tags]    job    build
    [Setup]    Create Job From Template    ${test_job_name}    ${job_sleep}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${build_number} =    Start Jenkins Job    ${test_job_name}
    Wait Until Build Starts    ${test_job_name}    ${build_number}    60 sec 
    Wait Until Build Finishes    ${test_job_name}    ${build_number}
    ${build_finished} =    Is Build Finished    ${test_job_name}    ${build_number}
    Should Be True    ${build_finished}

Get Next Build Number
    [Tags]    job    build
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${random_int} =    Evaluate    random.randint(2, 10)    modules=random
    :FOR    ${run}    IN RANGE    ${random_int}
    \    ${next_build_before} =    Get Next Build Number    ${test_job_name}
    \    Should Be Equal As Integers    ${run + 1}    ${next_build_before}
    \    ${build_number} =    Start Jenkins Job    ${test_job_name}
    \    Wait Until Build Finishes    ${test_job_name}    ${build_number}
    \    ${next_build_after} =    Get Next Build Number    ${test_job_name}
    \    Should Be Equal As Integers    ${run + 2}    ${next_build_after}
