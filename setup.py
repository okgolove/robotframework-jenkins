from os.path import join, dirname
<<<<<<< HEAD
from setuptools import setup
=======
from setuptools import setup, find_packages
>>>>>>> release/0.1.1

exec(open(join(dirname(__file__),
               'src', 'JenkinsLibrary', 'version.py')).read())
PACKAGE = 'robotframework-jenkins'
DESCRIPTION = '''Library for Robot Framework for Jenkins interaction'''
REQUIREMENTS = [
<<<<<<< HEAD
    'python-jenkins==0.4.15',
    'robotframework==3.0.2',
    'requests==2.18.4'
]
=======
    'robotframework==3.0.2',
    'requests==2.18.4',
    'python-jenkins'
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
>>>>>>> release/0.1.1

setup(
    name=PACKAGE,
    package_dir={'': 'src'},
<<<<<<< HEAD
    packages=['JenkinsLibrary'],
=======
    packages=find_packages('src'),
>>>>>>> release/0.1.1
    version=VERSION,
    description=DESCRIPTION,
    author='Mikhail Naletov',
    author_email='admin@markeloff.net',
    url='https://github.com/okgolove/robotframework-jenkins',
    keywords=['jenkins', 'robotframework', 'robot', 'testing'],
<<<<<<< HEAD
    install_requires=REQUIREMENTS
=======
    classifiers=CLASSIFIERS,
    install_requires=REQUIREMENTS,
>>>>>>> release/0.1.1
)
