require 'jenkins_api_client'

class JobsController < ApplicationController
  before_action :set_jenkins
  before_action :set_job, only: [:show]

  def index
    @jobs = @jenkins.list_jobs
  end

  def show
  end

  private

  def set_job
    @job = @jenkins.job(params[:id])
  end

  def set_jenkins
    @jenkins = Jenkin.first
  end
end
