class SettingsController < ApplicationController
  before_action :can_access
  before_action :set_require_authentication,
        only: [:role]

  def roles
    @settings = Setting.new
    @roles = set_available_roles
    @areas = set_available_areas
  end

  def update_roles
    @roles = set_available_roles
    @areas = set_available_areas

    set_available_areas.each do |a|
      setting_area = Setting.find_or_initialize_by(:key => 'role_area_' + a)
      setting_area.key = 'role_area_' + a
      setting_area.value = ActiveSupport::JSON.encode(params[a])
      setting_area.save
    end
    
    flash['alert'] = 'success'
    flash['notice'] = 'Roles was successfully updated.'

    render :roles
  end

  private 

  def can_access
    unless helpers.is_admin?
      redirect_to dashboard_path, alert: 'danger', notice: 'You cannot access that area!'
    end
  end

  def set_available_roles
    ['admin', 'manager', 'employee', 'only_task']
  end

  def set_available_areas
    ['users', 'clients', 'service_types', 'services', 'tasks']
  end
end
