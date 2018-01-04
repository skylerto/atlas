class DeploymentsController < ApplicationController
  before_action :set_deployment, only: [:show, :edit, :update, :destroy, :add_service, :remove_service, :update_service]

  def update_service
    version = Version.find(service_params[:id])
    service = Service.find_by(name: service_params[:name])
    versions = @deployment.versions.select { |v| v.service == service }
    @deployment.versions.delete versions
    @deployment.versions << version
    @deployment.save
    redirect_to edit_deployment_url(@deployment)
  end

  ##
  # Action to add a service version from a deployment
  #
  def add_service
    service = Service.find(service_params[:id])
    if service.nil? || service.versions.empty?
      msg =  "No versions of #{service.name} available"
      Rails.logger.error msg
      link = "Please add versions to #{view_context.link_to(service.name, service_path(service))}"
      redirect_to edit_deployment_url(@deployment), flash: { error: "#{msg}, #{link}" }
    else
      version = service.versions.first
      @deployment.versions << version
      @deployment.save
      redirect_to edit_deployment_url(@deployment)
    end
  end

  ##
  # Action to remove a service version from a deployment
  #
  def remove_service
    service = Service.find(params[:service_id])
    version = Version.find(params[:version_id])
    @deployment.versions.delete(version)
    render :edit
  end

  # GET /deployments
  # GET /deployments.json
  def index
    @deployments = Deployment.all
  end

  # GET /deployments/1
  # GET /deployments/1.json
  def show
  end

  # GET /deployments/new
  def new
    @deployment = Deployment.new
  end

  # GET /deployments/1/edit
  def edit
  end

  # POST /deployments
  # POST /deployments.json
  def create
    @deployment = Deployment.new(deployment_params)

    respond_to do |format|
      if @deployment.save
        format.html { redirect_to @deployment, notice: 'Deployment was successfully created.' }
        format.json { render :show, status: :created, location: @deployment }
      else
        format.html { render :new }
        format.json { render json: @deployment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deployments/1
  # PATCH/PUT /deployments/1.json
  def update
    respond_to do |format|
      if @deployment.update(deployment_params)
        services_params(@deployment).each do |service_name, version_name|
          version = Version.find_by(name: version_name)
          @deployment.versions << version if version
        end
        @deployment.save
        format.html { redirect_to @deployment, notice: 'Deployment was successfully updated.' }
        format.json { render :show, status: :ok, location: @deployment }
      else
        format.html { render :edit }
        format.json { render json: @deployment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deployments/1
  # DELETE /deployments/1.json
  def destroy
    @deployment.destroy
    respond_to do |format|
      format.html { redirect_to deployments_url, notice: 'Deployment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def service_params
      params.require(:service).permit(:version, :id, :name)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_deployment
      @deployment = Deployment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deployment_params
      params.require(:deployment).permit(:environment_id, :name)
    end

    def services_params(deployment)
      params.require(:environment).permit(deployment.environment.versions.map { |v| v.service.name})
    end
end
