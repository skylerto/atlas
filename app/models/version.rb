class Version < ApplicationRecord
  include JenkinsControllerConcern

  belongs_to :service
  has_and_belongs_to_many :environments
  has_and_belongs_to_many :deployments

  def deployment_status(deployment)
    environment = deployment.environment.name
    version = self.name
    job = load_jenkins.job(self.service.name)
    job.build(name: "#{environment} - #{version}").status
  end

  def deploy(environment:, jenkins:)
    job = jenkins.job self.service.name
    job.run_build({
      SEMVER_NUMBER: self.name,
      ENVIRONMENT: environment.name
    })
  end
end
