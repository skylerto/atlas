class EnvironmentsController < ApplicationController
  include JenkinsControllerConcern

  before_action :set_environment, only: [:show, :edit, :update, :destroy]
  before_action :set_jenkins_jobs, only: [:edit, :update]

  # GET /environments
  # GET /environments.json
  def index
    @environments = Environment.all
  end

  # GET /environments/1
  # GET /environments/1.json
  def show
  end

  # GET /environments/new
  def new
    @environment = Environment.new
  end

  # GET /environments/1/edit
  def edit
  end

  # POST /environments
  # POST /environments.json
  def create
    @environment = Environment.new(environment_params)
    # Create or Save Services
    create_or_save_services
    respond_to do |format|
      if @environment.save
        format.html { redirect_to @environment, notice: 'Environment was successfully created.' }
        format.json { render :show, status: :created, location: @environment }
      else
        format.html { render :new }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /environments/1
  # PATCH/PUT /environments/1.json
  def update
    create_or_save_services
    respond_to do |format|
      if @environment.update(environment_params)
        format.html { redirect_to @environment, notice: 'Environment was successfully updated.' }
        format.json { render :show, status: :ok, location: @environment }
      else
        format.html { render :edit }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environments/1
  # DELETE /environments/1.json
  def destroy
    @environment.destroy
    respond_to do |format|
      format.html { redirect_to environments_url, notice: 'Environment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def create_or_save_services
      services = params[:services]
      environment_id = params[:id]
      all_jobs = @jenkins.jobs
      services.each do |service|
        job = all_jobs.select { |j| j.name == service }
        version = job.first.current_build.display_name unless job.empty?
        s = Service.find_or_initialize_by(name: service)
        s.name = service
        s.environment_id = environment_id
        s.version = version
        s.save
        # begin
        #   Service.update(name: service, environment_id: environment_id, version: version)
        # rescue ActiveRecord::RecordNotFound
        #   Service.new(name: service, environment_id: environment_id, version: version).save!
        # end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Environment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def environment_params
      params.require(:environment).permit(:name, :version)
    end

    def set_jenkins_jobs
      load_jenkins
      @jobs = []
      @all_jobs = @jenkins.jobs
      if @environment.services
        @all_jobs.each do |job|
          job = @environment.services.select { |j| j.name == job.name }
          @jobs << job.first unless job.empty?
        end
      end
    end
end
