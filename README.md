[![PyPI version](https://badge.fury.io/py/robotframework-jenkins.svg)](https://badge.fury.io/py/robotframework-jenkins)
![Supported Jenkins Version](https://img.shields.io/badge/Tested%20with%20jenkins-%3E2.176.1%20%3C2.234-blue)

JenkinsLibrary for Robot Framework
==============================

Introduction
------------

JenkinsLibrary is a Robot Framework test
library which helps you to involve Jenkins in your tests.

Installation
------------

Just run:

    pip install robotframework-jenkins

Usage
------------

You need to import Jenkins library:

    *** Settings ***
    Library    JenkinsLibrary
Then, you need to initialize Jenkins server with keyword:

    Set Jenkins Server    url=http://example.com:8080    username=admin    password=admin

Example
------------
    *** Settings ***
    Library    JenkinsLibrary

    *** Test Cases ***
    Jenkins Create And Run Job
        [Setup]    Set Jenkins Server    url=http://example.com:8080    username=admin    password=admin
        Create Jenkins Job    test_job
        Start Jenkins Job    test_job

