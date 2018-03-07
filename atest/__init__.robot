*** Settings ***
Library    JenkinsLibrary
Suite Setup    Global Setup

*** Variables ***
${url}    http://127.0.0.1:8080
${templates_dir}    templates
${job_parameterized_scratch}    job_parameterized_scratch.xml
&{job_parameterized_scratch_parameters}    param_string=expected_string    param_bool=False
${test_job_name}    test_job
${second_test_job_name}    blablabla_job

*** Keywords ***
Wait For Container
    Wait Until Keyword Succeeds    2 min    5 sec\
    ...    Is Jenkins Up    url=${jenkins_address}

Global Setup
    Set Global Variable    ${jenkins_address}    ${url}
    Set Global Variable    ${templates_dir}    atest/${templates_dir}
    Set Global Variable    ${job_parameterized_scratch}    ${job_parameterized_scratch}
    Set Global Variable    ${test_job_name}    ${test_job_name}
    Set Global Variable    ${second_test_job_name}    ${second_test_job_name}
    Set Global Variable    ${job_parameterized_scratch_parameters}    &{job_parameterized_scratch_parameters}
    Wait For Container
