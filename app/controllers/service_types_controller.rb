class ServiceTypesController < ApplicationController
    before_action :can_access
    before_action :set_service_type, only: [:show, :edit, :update, :destroy]
    before_action :require_authentication,
        only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /service_types
  def index
    @service_types = ServiceType.all
  end

  # GET /service_types/1
  def show
  end

  # GET /service_types/new
  def new
    @service_type = ServiceType.new
  end

  # GET /service_types/1/edit
  def edit
  end

  # POST /service_types
  def create
    @service_type = ServiceType.new(service_type_params)

    if @service_type.save
      redirect_to @service_type, alert: 'success', notice: 'Service type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /service_types/1
  def update
    if @service_type.update(service_type_params)
      redirect_to @service_type, alert: 'success', notice: 'Service type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /service_types/1
  def destroy
    @service_type.destroy
    redirect_to service_types_url, alert: 'success', notice: 'Service type was successfully destroyed.'
  end

  private

    def can_access
        unless helpers.role_can?
            redirect_to dashboard_path, alert: 'danger', notice: 'You cannot access that area!'
        end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_service_type
      @service_type = ServiceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_type_params
      params.require(:service_type).permit(:name)
    end
end
