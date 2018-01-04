module JenkinsControllerConcern extend ActiveSupport::Concern
  included do
    helper_method :load_jenkins
    helper_method :load_jobs
  end

  def load_jenkins
    @jenkins ||= Jenkin.first
  end

  # Figure out how to cache this
  def load_jobs
    @jobs = load_jenkins.jobs
  end
end
