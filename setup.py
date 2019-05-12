from os.path import join, dirname
from setuptools import setup, find_packages

exec(open(join(dirname(__file__),
               'src', 'JenkinsLibrary', 'version.py')).read())
PACKAGE = 'robotframework-jenkins'
DESCRIPTION = '''Library for Robot Framework for Jenkins interaction'''
REQUIREMENTS = [
    'python-jenkins==0.4.15',
    'robotframework==3.0.2',
    'requests==2.18.4'
]

with open('README.md') as f:
    LONG_DESCRIPTION = f.read()

CLASSIFIERS = '''
Development Status :: 5 - Production/Stable
License :: OSI Approved :: MIT License
Operating System :: OS Independent
Programming Language :: Python
Programming Language :: Python :: 2
Programming Language :: Python :: 3
Topic :: Software Development :: Testing
Framework :: Robot Framework
Framework :: Robot Framework :: Library
'''.strip().splitlines()

setup(
    name=PACKAGE,
    package_dir={'': 'src'},
    packages=find_packages('src'),
    version=VERSION,
    description=DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    long_description_content_type="text/markdown",
    author='Mikhail Naletov',
    author_email='admin@markeloff.net',
    url='https://github.com/okgolove/robotframework-jenkins',
    keywords=['jenkins', 'robotframework', 'robot', 'testing'],
    classifiers=CLASSIFIERS,
    install_requires=REQUIREMENTS,
)
