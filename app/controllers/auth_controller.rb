class AuthController < ApplicationController
    layout 'home/auth'

    before_action :require_no_authentication, only: [:new, :create]
    before_action :require_authentication, only: :destroy

    def new
        @auth = Auth.new(session)
    end

    def create
        @auth = Auth.new(session, params[:auth])

        if @auth.authenticate!
            redirect_to dashboard_path
        else
            render :new
        end
    end

    def destroy
        auth.destroy
        redirect_to root_path, notice: t('flash.notice.signed_out')
    end
end
