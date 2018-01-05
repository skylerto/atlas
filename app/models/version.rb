class Version < ApplicationRecord
  include JenkinsControllerConcern

  belongs_to :service
  has_and_belongs_to_many :environments
  has_and_belongs_to_many :deployments

  def deployment_status(deployment)
    environment = deployment.environment.name
    version = self.name
    job = load_jenkins.job(self.service.name)
    build = job.build(name: self.build_number)
    return 'failure' if build
    build.status
  end

  def deploy(environment:, jenkins:)
    job = jenkins.job self.service.name
    build_number = job.run_build({
      SEMVER_NUMBER: self.name,
      ENVIRONMENT: environment.name
    })
    self.build_number = build_number
    self.save
  end
end
