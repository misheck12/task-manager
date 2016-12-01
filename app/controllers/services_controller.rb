class ServicesController < ApplicationController
  before_action :can_access
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :require_authentication,
        only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /services
  def index
    @services = Service.all
  end

  # GET /services/1
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
    @client = Client.all
    @service_type = ServiceType.all
  end

  # GET /services/1/edit
  def edit
    @client = Client.all
    @service_type = ServiceType.all
  end

  # POST /services
  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to @service, alert: 'success', notice: 'Service was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /services/1
  def update
    if @service.update(service_params)
      redirect_to @service, alert: 'success', notice: 'Service was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    redirect_to services_url, alert: 'success', notice: 'Service was successfully destroyed.'
  end

  private
  
    def can_access
        unless helpers.role_can?
            redirect_to dashboard_path, alert: 'danger', notice: 'You cannot access that area!'
        end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params
      .require(:service)
      .permit(:service_type_id, :client_id, :active, :suspended, :suspended_at, :info)
    end
end
