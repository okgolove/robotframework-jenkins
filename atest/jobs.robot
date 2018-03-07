*** Settings ***
Library    Collections
Library    OperatingSystem
Library    JenkinsLibrary
Resource    lib/jenkins_keywords.robot
Suite Setup    Set Jenkins Server    url=${jenkins_address}    username=admin    password=admin

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

Create Job From Template
    [Tags]    job
    [Setup]    Create Job From Template    ${test_job_name}    ${job_parameterized_scratch}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${parameters} =    Get Jenkins Job Parameters    ${test_job_name}
    Should Be True    ${parameters}
    Should Be Equal    param_string    ${parameters[0]['name']}
    Should Be Equal    param_bool    ${parameters[1]['name']}

Delete Inexistent Job
    [Tags]    job
    Run Keyword And Expect Error    There is no specified job in Jenkins: ${test_job_name}\
    ...    Delete Jenkins Job    ${test_job_name}

Disable Inexistent Job
    [Tags]    job
    Run Keyword And Expect Error    There is no specified job in Jenkins: ${test_job_name}\
    ...    Disable Jenkins Job    ${test_job_name}

Enable Inexistent Job
    [Tags]    job
    Run Keyword And Expect Error    There is no specified job in Jenkins: ${test_job_name}\
    ...    Disable Jenkins Job    ${test_job_name}

Enable Disabled Job
    [Tags]    job
    [Setup]    Create And Disable Job
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Enable Jenkins Job    ${test_job_name}

Disable Enabled Job
    [Tags]    job
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    Disable Jenkins Job    ${test_job_name}

Get Job XML
    [Tags]    job
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${job_xml} =    Get Jenkins Job XML    ${test_job_name}
    Should Start With    ${job_xml}    <?xml version=

Get Job And Compare XML
    [Tags]    job
    [Setup]    Create Job From Template    ${test_job_name}    ${job_parameterized_scratch}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${job_xml} =    Get Jenkins Job XML    ${test_job_name}
    ${template_xml} =    Get File    ${templates_dir}/${job_parameterized_scratch}
    Should Be Equal As Strings    ${job_xml}    ${template_xml}

Check Job Parameters (parameters is inexistent)
    [Tags]    job
    [Setup]    Create Jenkins Job    ${test_job_name}
    [Teardown]    Delete Jenkins Job    ${test_job_name}
    ${parameters} =    Get Jenkins Job Parameters    ${test_job_name}
    Should Not Be True    ${parameters}
