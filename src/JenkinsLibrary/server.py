import jenkins


def is_server_initialized(func):
    def _decorator(self, *args, **kwargs):
        if not self.initialized:
            raise RuntimeError('Jenkins server was not initialized')
        return func(self, *args, **kwargs)
    return _decorator


class Server(object):
    def __init__(self):
        self.initialized = False

    def initialize(self, url, username, password):
        self.server = jenkins.Jenkins(url, username, password)
        try:
            self.server.get_whoami()
        except jenkins.JenkinsException as e:
            raise RuntimeError(
                'Can\'t connect to Jenkins: {0}'.format(e))
        else:
            self.initialized = True

    @is_server_initialized
    def get_jobs(self):
        return self.server.get_jobs()

    @is_server_initialized
    def get_job(self, name):
        try:
            job = self.server.get_job_info(name)
        except jenkins.NotFoundException:
            raise RuntimeError('Can\'t find specified job: {0}'.format(name))
        return job

    @is_server_initialized
    def create_job(self, name):
        try:
            self.server.create_job(name, jenkins.EMPTY_CONFIG_XML)
        except jenkins.JenkinsException:
            raise RuntimeError(
                'Specified job already exists: {0}'.format(name))

    @is_server_initialized
    def delete_job(self, name):
        try:
            self.server.delete_job(name)
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job in Jenkins: {0}'.format(name))

    @is_server_initialized
    def disable_job(self, name):
        try:
            self.server.disable_job(name)
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job in Jenkins: {0}'.format(name))

    @is_server_initialized
    def enable_job(self, name):
        try:
            self.server.enable_job(name)
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job in Jenkins: {0}'.format(name))

    @is_server_initialized
    def build_job(self, name, params={}):
        if not isinstance(params, dict):
            raise RuntimeError('Params must be a dictionary, not {0}'.format(
                type(params).__name__))
        try:
            self.server.build_job(name, params)
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job in Jenkins: {0}'.format(name))
        # TODO: return build number

    @is_server_initialized
    def get_builds(self, name):
        try:
            builds = self.server.get_job_info(name)
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job in Jenkins: {0}'.format(name))
        return builds
