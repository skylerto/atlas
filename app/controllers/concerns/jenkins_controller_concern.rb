module JenkinsControllerConcern extend ActiveSupport::Concern
  included do
    helper_method :load_jenkins
    helper_method :load_jobs
    helper_method :load_job_names
  end if self.respond_to? :helper_method

  def load_jenkins
    @jenkins ||= Jenkin.first
  end

  # Figure out how to cache this
  def load_jobs
    @jobs = load_jenkins.jobs
  end

  def load_job_names
    @job_names = load_jenkins.job_names
  end
end
