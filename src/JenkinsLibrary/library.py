import requests
from .server import Server
from .version import VERSION

__version__ = VERSION


class JenkinsLibrary(object):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    ROBOT_LIBRARY_VERSION = __version__

    def __init__(self):
        self.jenkins = Server()

    def set_jenkins_server(self, url, username, password):
        self.jenkins.initialize(url=url, username=username, password=password)

    def is_jenkins_up(self, url):
        try:
            r = requests.get("{0}/login".format(url))
        except requests.ConnectionError:
            raise RuntimeError('Jenkins server {0} is not available')
        else:
            if r.status_code != 200:
                raise RuntimeError(
                    'Jenkins server {0} is not available, status code:{1}'.
                    format(url, r.status_code))

    def get_jenkins_jobs(self):
        return self.jenkins.get_jobs()

    def get_jenkins_job_by_name(self, name):
        return self.jenkins.get_job(name)

    def create_jenkins_job(self, name, template=None):
        self.jenkins.create_job(name, template)

    def delete_jenkins_job(self, name):
        self.jenkins.delete_job(name)

    def disable_jenkins_job(self, name):
        self.jenkins.disable_job(name)

    def enable_jenkins_job(self, name):
        self.jenkins.enable_job(name)

    def start_jenkins_job(self, name, params={}):
        return self.jenkins.build_job(name, params)

    def get_jenkins_job_builds(self, name):
        return self.jenkins.get_builds(name)

    def get_jenkins_job_xml(self, name):
        return self.jenkins.get_job_config(name)

    def get_jenkins_job_parameters(self, name):
        return self.jenkins.get_job_parameters(name)

    def get_next_build_number(self, name):
        return self.jenkins.get_next_build_number(name)
