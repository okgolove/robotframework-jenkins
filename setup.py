from os.path import join, dirname
from setuptools import setup, find_packages

exec(open(join(dirname(__file__),
               'src', 'JenkinsLibrary', 'version.py')).read())
PACKAGE = 'robotframework-jenkins'
DESCRIPTION = '''Library for Robot Framework for Jenkins interaction'''
REQUIREMENTS = [
    'six>=1.3.0',
    'pbr>=0.8.2',
    'multi_key_dict',
    'robotframework==3.0.2',
    'requests==2.18.4'
]
CLASSIFIERS = '''
License :: OSI Approved :: Apache Software License
Development Status :: 5 - Production/Stable
Programming Language :: Python :: 2
Programming Language :: Python :: 2.7
Programming Language :: Python :: 3
Programming Language :: Python :: 3.3
Programming Language :: Python :: 3.4
Programming Language :: Python :: 3.5
Programming Language :: Python :: 3.6
Topic :: Software Development :: Testing
Framework :: Robot Framework
'''

setup(
    name=PACKAGE,
    package_dir={'': 'src'},
    packages=find_packages('src'),
    version=VERSION,
    description=DESCRIPTION,
    author='Mikhail Naletov',
    author_email='admin@markeloff.net',
    url='https://github.com/okgolove/robotframework-jenkins',
    keywords=['jenkins', 'robotframework', 'robot', 'testing'],
    classifiers=CLASSIFIERS,
    install_requires=REQUIREMENTS,
)
