[![Build Status](https://travis-ci.org/okgolove/robotframework-jenkins.svg?branch=master)](https://travis-ci.org/okgolove/robotframework-jenkins)

JenkinsLibrary for Robot Framework
==============================

Introduction
------------

JenkinsLibrary is a Robot Framework test
<<<<<<< HEAD
library which helps you to involve Jenkins in your tests.
=======
library which helps you to involve Jenkins in your tests.
>>>>>>> release/0.1.1


Installation
------------

Just run:

    pip install robotframework-jenkins
<<<<<<< HEAD
=======

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
>>>>>>> release/0.1.1
