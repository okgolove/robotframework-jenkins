.PHONY: test build publish

build:
	python setup.py sdist bdist_wheel --universal

publish:
	twine upload dist/*

jenkins-docker:
	docker build --pull -t jenkins-test atest/docker
	docker run --rm -p 127.0.0.1:8080:8080 -e JAVA_OPTS=-Djenkins.install.runSetupWizard=false -d jenkins-test

test:
	robot --loglevel DEBUG --pythonpath src/ atest/

test-docker: jenkins-docker test
