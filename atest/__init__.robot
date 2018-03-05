*** Settings ***
Library    JenkinsLibrary
Suite Setup    Global Setup

*** Variables ***
${url}    http://127.0.0.1:8080
${templates_dir}    templates
${job_parameterized_scratch}    job_parameterized_scratch.xml

*** Keywords ***
Wait For Container
    Wait Until Keyword Succeeds    2 min    5 sec\
    ...    Is Jenkins Up    url=${jenkins_address}

Global Setup
    Set Global Variable    ${jenkins_address}    ${url}
    Set Global Variable    ${templates_dir}    atest/${templates_dir}
    Set Global Variable    ${job_parameterized_scratch}    ${job_parameterized_scratch}
    Wait For Container
