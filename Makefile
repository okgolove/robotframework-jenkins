.PHONY: test build publish

build:
	python setup.py sdist bdist_wheel --universal

publish:
	twine upload dist/*

test:
	robot --loglevel DEBUG --pythonpath src/ atest/

