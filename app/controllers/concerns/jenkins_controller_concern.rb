module JenkinsControllerConcern extend ActiveSupport::Concern

  included do
    helper_method :load_jenkins
    helper_method :load_jobs
  end

  def load_jenkins
    @jenkins ||= Jenkin.first
  end

  def load_jobs
    @jobs = Rails.cache.fetch('jobs') do
      load_jenkins.jobs
    end
  end
end
