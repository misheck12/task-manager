class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  delegate :current_user, :user_signed_in?, to: :auth
  before_action :set_locale
  helper_method :current_user, :user_signed_in?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def auth
    Auth.new(session)
  end

  def require_authentication
    unless user_signed_in?
      redirect_to new_auth_path, alert: t('flash.alert.needs_login')
    end
  end

  def require_no_authentication
    if user_signed_in?
      redirect_to dashboard_path
    end
  end
end
