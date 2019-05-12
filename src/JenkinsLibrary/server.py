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
    def create_job(self, name, template):
        if not template:
            template = jenkins.EMPTY_CONFIG_XML
        try:
            self.server.create_job(name, template)
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
        job_params = self.get_job_parameters(name)
        build_number = self.get_next_build_number(name)
        if job_params:
            if not params:
                raise RuntimeError('This is parameterized job, you have to '
                                   'specify params dicitionary')
                self.server.build_job(name, params)
        else:
            if not params:
                self.server.build_job(name, params)
            else:
                raise RuntimeError('This is not parameterized job, you don\'t '
                                   'have to no specify params dicitionary')
        return build_number

    @is_server_initialized
    def get_next_build_number(self, name):
        return self.get_builds(name)['nextBuildNumber']

    @is_server_initialized
    def get_builds(self, name):
        try:
            builds = self.server.get_job_info(name)
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job in Jenkins: {0}'.format(name))
        return builds

    @is_server_initialized
    def is_build_finished(self, name, build_number):
        try:
            build = self.server.get_build_info(name, int(build_number))
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job or build in Jenkins: {0}'.format(name))
        if not build['building'] and build['result'] is not None:
            return True
        return False

    @is_server_initialized
    def is_build_started(self, name, build_number):
        try:
            build = self.server.get_build_info(name, int(build_number))
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job or build in Jenkins: job: {0}, '
                'build: {1}'.format(name, build_number))
        if build['building'] and build['result'] is None:
            return True
        return False

    @is_server_initialized
    def get_job_config(self, name):
        try:
            job_xml = self.server.get_job_config(name)
        except jenkins.NotFoundException:
            raise RuntimeError(
                'There is no specified job or build in Jenkins: job: {0}, '
                'build: {1}'.format(name, build_number))
        return job_xml

    @is_server_initialized
    def get_job_parameters(self, name):
        job_info = self.get_job(name)
        params = []
        if job_info['property']:
            for param in job_info['property'][0]['parameterDefinitions']:
                params.append({
                    'name': param['name'],
                    'description': param['description'],
                    'type': param['type'],
                    'value': param['defaultParameterValue']['value']
                })
        return params
