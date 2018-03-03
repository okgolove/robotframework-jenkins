*** Settings ***
Library    JenkinsLibrary
Suite Setup    Global Setup

*** Variables ***
${url}    http://127.0.0.1:8080

*** Keywords ***
Wait For Container
    Wait Until Keyword Succeeds    2 min    5 sec\
    ...    Is Jenkins Up    url=${jenkins_address}

Global Setup
    Set Global Variable    ${jenkins_address}    ${url}
    Wait For Container
