*** Settings ***
Library    JenkinsLibrary

*** Test Cases ***
Keyword Without Init
    [Tags]    init    auth
    Run Keyword And Expect Error    Jenkins server was not initialized    Get Jenkins Job By Name    example

Normal Init Jenkins
    [Tags]    init    auth
    Set Jenkins Server    url=http://127.0.0.1:8080    username=admin    password=admin

Wrong Username
    [Tags]    init    auth
    Run Keyword And Expect Error    Can't connect to Jenkins: Error in request. Possibly authentication failed [401]: Invalid password/token for user: nimda\
    ...    Set Jenkins Server    url=http://127.0.0.1:8080    username=nimda    password=admin

Wrong Password
    [Tags]    init    auth
    Run Keyword And Expect Error    Can't connect to Jenkins: Error in request. Possibly authentication failed [401]: Invalid password/token for user: admin\
    ...    Set Jenkins Server    url=http://127.0.0.1:8080    username=admin    password=nimda

Wrong URL
    [Tags]    init    auth
    Run Keyword And Expect Error    Can't connect to Jenkins: Error in request: [Errno 111] Connection refused\
    ...    Set Jenkins Server    url=http://127.1.1.1    username=admin    password=admin

All Of These Are Wrong
    [Tags]    init    auth
    Run Keyword And Expect Error    Can't connect to Jenkins: Error in request: [Errno 111] Connection refused\
    ...    Set Jenkins Server    url=http://127.0.0.1:11111    username=nimda    password=nimda
