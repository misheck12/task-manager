class UsersController < ApplicationController
    before_action :require_authentication,
        only: [:new, :create, :show, :edit, :update, :edit_photo, :update_photo, :edit_background, :update_background]
    before_action :can_change,
        only: [:edit, :update, :edit_photo, :update_photo, :edit_background, :update_background]

    def new
        @user = User.new
        render layout: 'home/auth'
    end

    def create
        @user = User.new(user_params)
        if @user.save
            SignupMailer.confirm_email(@user).deliver
            redirect_to root_path, notice: I18n.t('confirmations.needed')
        else
            render action: :new, layout: 'home/auth'
        end
    end

    def show
        @user = current_user
    end

    def edit
        @user = current_user
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

    private

    def user_params
        params
            .require(:user)
            .permit(:email, :full_name, :photo, :background, :password, :password_confirmation)
    end

    def can_change
        unless user_signed_in? && current_user === user
            redirect_to user_path(params[:id])
        end
    end

    def user
        @user ||= User.find(params[:id])
    end
end