*** Settings ***
Library    Collections
Library    OperatingSystem
Library    JenkinsLibrary

*** Keywords ***
Create And Disable Job
    Create Jenkins Job    ${test_job_name}
    Disable Jenkins Job    ${test_job_name}

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
    Should Be Equal    ${second_job['url']}    ${jenkins_address}/job/${second_test_job_name}/
    ${first_job} =    Get From List    ${jobs}    1
    Should Be Equal    ${first_job['name']}    ${test_job_name}
    Should Be Equal    ${first_job['url']}    ${jenkins_address}/job/${test_job_name}/

Create Job From Template
    [Arguments]    ${job_name}    ${template_file}
    ${template} =    Get File    ${templates_dir}/${template_file}
    Create Jenkins Job    ${job_name}    ${template}

Create Job And Run Multiple Builds
    [Arguments]    ${job_name}    ${count}=2
    Create Jenkins Job    ${job_name}
    :FOR    ${run}    IN RANGE    ${count}
    \    ${build_number} =    Start Jenkins Job    ${job_name}
    \    Wait Until Build Finishes    ${job_name}    ${build_number}

Check Build Is Finished
    [Arguments]    ${job_name}    ${build_number}
    ${build_finished} =    Is Build Finished    ${test_job_name}    ${build_number}
    Should Be True    ${build_finished}

Check Build Is Started
    [Arguments]    ${job_name}    ${build_number}
    ${build_started} =    Is Build Started    ${test_job_name}    ${build_number}
    Should Be True    ${build_started}

Wait Until Build Finishes
    [Arguments]    ${job_name}    ${build_number}   ${timeout}=20 sec  ${period}=2 sec
    Wait Until Keyword Succeeds    ${timeout}    ${period}\
    ...   Check Build Is Finished   ${test_job_name}    ${build_number} 

Wait Until Build Starts
    [Arguments]    ${job_name}    ${build_number}   ${timeout}=20 sec  ${period}=2 sec
    Wait Until Keyword Succeeds    ${timeout}    ${period}\
    ...   Check Build Is Started   ${test_job_name}    ${build_number} 
