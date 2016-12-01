class UsersController < ApplicationController
    before_action :can_access
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_authentication,
        only: [:index, :new, :create, :show, :edit, :update, :edit_photo, :update_photo, :edit_background, :update_background, :edit_profile, :update_profile, :edit_password, :update_password]
    before_action :can_change,
        only: [:edit_photo, :update_photo, :edit_background, :update_background, :edit_profile, :update_profile, :edit_password, :update_password]

    # GET /users
    def index
      @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            SignupMailer.confirm_email(@user).deliver
            redirect_to edit_user_path, notice: I18n.t('confirmations.needed')
        else
            render action: :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @user.update_attribute(:full_name, user_params[:full_name])
            redirect_to edit_user_path, alert: 'success', notice: t('alert.msg.success', item: t('.profile'))
        else
            redirect_to edit_user_path, alert: 'danger', notice: t('alert.msg.error', item: t('.profile'))
        end
    end

    def edit_photo
        @user = current_user
    end

    def update_photo
        if @user.update_attribute(:photo, user_params[:photo])
            redirect_to edit_photo_user_path, alert: 'success', notice: t('alert.msg.success', item: t('.photo'))
        else
            redirect_to edit_photo_user_path, alert: 'danger', notice: t('alert.msg.error', item: t('.photo'))
        end
    end

    def edit_background
        @user = current_user
    end

    def update_background
        if @user.update_attribute(:background, user_params[:background])
            redirect_to edit_photo_user_path, alert: 'success', notice: t('alert.msg.success', item: t('.background'))
        else
            redirect_to edit_photo_user_path, alert: 'danger', notice: t('alert.msg.error', item: t('.background'))
        end
    end

    def edit_profile
        @user = current_user
    end

    def update_profile
        if @user.update_attribute(:full_name, user_params[:full_name])
            redirect_to edit_profile_user_path, alert: 'success', notice: t('alert.msg.success', item: t('.full_name'))
        else
            redirect_to edit_profile_user_path, alert: 'danger', notice: t('alert.msg.error', item: t('.full_name'))
        end
    end

    def edit_password
    end

    def update_password
        if (params[:user][:password] != params[:user][:password_confirmation])
            redirect_to edit_password_user_path, alert: 'danger', notice: 'Password confirmation do not match'
            return
        end
        
        unless current_user.try(:authenticate, params[:user][:current_password])
            redirect_to edit_password_user_path, alert: 'danger', notice: 'Current Password seems to be wrong'
            return
        end

        if @user.update_attribute(:password, user_params[:password])
            redirect_to edit_password_user_path, alert: 'success', notice: t('alert.msg.success', item: t('.password'))
        else
            redirect_to edit_password_user_path, alert: 'danger', notice: t('alert.msg.error', item: t('.password'))
        end
    end

    # DELETE /tasks/1
     def destroy
      @user.destroy
      redirect_to users_url, alert: 'success', notice: 'User was successfully destroyed.'
     end

    private

    def can_access
        unless helpers.role_can?
            redirect_to dashboard_path, alert: 'danger', notice: 'You cannot access that area!'
        end
    end

    def user_params
        params
            .require(:user)
            .permit(:email, :full_name, :photo, :background, :role, :password, :password_confirmation)
    end

    def can_change
        unless user_signed_in? && current_user === user
            redirect_to user_path(params[:id])
        end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user
        @user ||= User.find(params[:id])
    end
end