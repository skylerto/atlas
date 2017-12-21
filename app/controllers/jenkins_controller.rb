class JenkinsController < ApplicationController
  before_action :set_jenkin, only: [:show, :edit, :update, :destroy]

  # GET /jenkins
  # GET /jenkins.json
  def index
    @jenkins = Jenkin.all
  end

  # GET /jenkins/1
  # GET /jenkins/1.json
  def show
  end

  # GET /jenkins/new
  def new
    @jenkin = Jenkin.new
  end

  # GET /jenkins/1/edit
  def edit
  end

  # POST /jenkins
  # POST /jenkins.json
  def create
    @jenkin = Jenkin.new(jenkin_params)

    respond_to do |format|
      if @jenkin.save
        format.html { redirect_to @jenkin, notice: 'Jenkin was successfully created.' }
        format.json { render :show, status: :created, location: @jenkin }
      else
        format.html { render :new }
        format.json { render json: @jenkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jenkins/1
  # PATCH/PUT /jenkins/1.json
  def update
    respond_to do |format|
      if @jenkin.update(jenkin_params)
        format.html { redirect_to @jenkin, notice: 'Jenkin was successfully updated.' }
        format.json { render :show, status: :ok, location: @jenkin }
      else
        format.html { render :edit }
        format.json { render json: @jenkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jenkins/1
  # DELETE /jenkins/1.json
  def destroy
    @jenkin.destroy
    respond_to do |format|
      format.html { redirect_to jenkins_url, notice: 'Jenkin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jenkin
      @jenkin = Jenkin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jenkin_params
      params.require(:jenkin).permit(:server_ip, :username, :password)
    end
end
