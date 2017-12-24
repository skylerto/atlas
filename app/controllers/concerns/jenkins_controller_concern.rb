module JenkinsControllerConcern extend ActiveSupport::Concern

  included do
    helper_method :load_jenkins
  end

  def load_jenkins
    @jenkins ||= Jenkin.first
  end
end
