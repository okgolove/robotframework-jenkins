*** Settings ***
Library    Collections
Library    JenkinsLibrary
Resource    lib/jenkins_keywords.robot
Suite Setup    Set Jenkins Server    url=${jenkins_address}    username=admin    password=admin

*** Test Cases ***
Wrong Params Type
    [Tags]    execute
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Run Keyword And Expect Error    Params must be a dictionary, not *\
    ...    Start Jenkins Job    ${test_job_name}    test_string

Run Inexistent Job
    [Tags]    execute
    Run Keyword And Expect Error    Can't find specified job: ${test_job_name}\
    ...    Start Jenkins Job    ${test_job_name}

Run Existent Unparameterized Job Without Params
    [Tags]    execute
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Start Jenkins Job    ${test_job_name}

Run Existent Unparameterized Job With Params
    [Tags]    execute
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Run Keyword And Expect Error    This is not parameterized job, you don't have to no specify params dicitionary\
    ...    Start Jenkins Job    ${test_job_name}    ${job_parameterized_scratch_parameters}

Run Existent Parameterized Job With Params
    [Tags]    execute
    [Setup]    Create Job From Template    ${test_job_name}    ${job_parameterized_scratch}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${build} =    Start Jenkins Job    ${test_job_name}    ${job_parameterized_scratch_parameters}

Run Existent Parameterized Job Without Params
    [Tags]    execute
    [Setup]    Create Job From Template    ${test_job_name}    ${job_parameterized_scratch}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Run Keyword And Expect Error    This is parameterized job, you have to specify params dicitionary\
    ...    Start Jenkins Job    ${test_job_name}

Compare Nuild Number
    [Tags]    execute
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${build_number} =    Start Jenkins Job    ${test_job_name}
    Sleep   10 Seconds
    ${next_build_before} =    Get Next Build Number    ${test_job_name}
    Should Be Equal As Integers    ${next_build_before}    ${build_number + 1}
