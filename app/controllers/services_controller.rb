class ServicesController < ApplicationController
  include JenkinsControllerConcern
  before_action :set_service, only: [:show, :edit, :update, :destroy, :add_version, :load_versions]
  # before_action :load_jobs, only: [:edit, :new, :create, :update]
  before_action :load_job_names, only: [:show, :load_versions]

  MAX_BUILDS = 10000

  def add_version
    version = Version.new(name: version_params[:name], service_id: @service.id)
    version.save
    render :show
  end

  def load_versions
    create_versions name: job_params[:name]
    render :show, notice: "Versions loaded from #{job_params[:name]} job"
  end

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        create_versions
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        create_versions
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def create_versions(name: @service.name)
      job = fetch_job name: name
      builds = job.builds MAX_BUILDS
      builds.each do |build|
        Version.find_or_initialize_by(name: build.display_name, service_id: @service.id).save
      end
    end

    def fetch_job(name:)
      @jenkins ||= load_jenkins
      @jenkins.job(name)
      # j = @jobs.select { |j| j.name == name }
      # return nil if j.empty?
      # j.first
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name)
    end

    def version_params
      params.require(:version).permit(:name)
    end

    def job_params
      params.require(:job).permit(:name)
    end
end
