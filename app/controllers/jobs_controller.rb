class JobsController < ApplicationController
  include JenkinsControllerConcern

  before_action :load_jenkins
  before_action :set_job, only: [:show]

  def index
    @jobs = @jenkins.jobs
  end

  def show
  end

  private

  def set_job
    @job = @jenkins.job(params[:id])
  end
end
