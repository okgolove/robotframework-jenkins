*** Settings ***
Library    JenkinsLibrary
Suite Setup    Wait For Container

*** Keywords ***
Wait For Container
    Wait Until Keyword Succeeds    2 min    5 sec\
    ...    Is Jenkins Up    url=http://127.0.0.1:8080
