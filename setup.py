from os.path import join, dirname
from setuptools import setup

exec(open(join(dirname(__file__),
               'src', 'JenkinsLibrary', 'version.py')).read())
PACKAGE = 'robotframework-jenkins'
DESCRIPTION = '''Library for Robot Framework for Jenkins interaction'''
REQUIREMENTS = [
    'python-jenkins==0.4.15',
    'robotframework==3.0.2',
    'requests==2.18.4'
]

setup(
    name=PACKAGE,
    package_dir={'': 'src'},
    packages=['JenkinsLibrary'],
    version=VERSION,
    description=DESCRIPTION,
    author='Mikhail Naletov',
    author_email='admin@markeloff.net',
    url='https://github.com/okgolove/robotframework-jenkins',
    keywords=['jenkins', 'robotframework', 'robot', 'testing'],
    install_requires=REQUIREMENTS
)
