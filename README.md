[![Build Status](https://travis-ci.org/okgolove/robotframework-jenkins.svg?branch=master)](https://travis-ci.org/okgolove/robotframework-jenkins)
[![PyPI version](https://badge.fury.io/py/robotframework-jenkins.svg)](https://badge.fury.io/py/robotframework-jenkins)

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

