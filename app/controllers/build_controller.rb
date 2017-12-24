class BuildController < ApplicationController
  include JenkinsControllerConcern

  before_action :set_build, only: [:show]
  def show
  end

  private

  def set_build
    name = params[:name]
    number = params[:number]
    jenkins = load_jenkins
    job = load_jenkins.client.job
    @build = Build.new(
      name: name,
      job: job,
      details: job.get_build_details(name, number)
    )
  end
end
