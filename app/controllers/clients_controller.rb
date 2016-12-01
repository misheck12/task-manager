class ClientsController < ApplicationController
  before_action :can_access
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :require_authentication,
        only: [:show, :edit, :update, :destroy, :new, :create]
    
  # GET /clients
  def index
    @clients = Client.all
  end

  # GET /clients/1
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client, alert: 'success', notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to @client, alert: 'success', notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, alert: 'success', notice: 'Client was successfully destroyed.'
  end

  private
    def can_access
        unless helpers.role_can?
            redirect_to dashboard_path, alert: 'danger', notice: 'You cannot access that area!'
        end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :address, :site)
    end
end
