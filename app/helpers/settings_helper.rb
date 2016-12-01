module SettingsHelper
    def is_admin?
        current_user.role == 'admin'
    end

    def role_can?
        base = params[:action].split('_').first

        base = case base
            when 'index'
                'show'
            when  'create'
                'new'
            when 'update'
                'edit'
            else
                base
            end

        role_permission(controller_name, base)
    end

    def role_permission(area, item, role = false)

    unless (role)
        role = current_user.role
    end

    area = Setting.where(:key => 'role_area_' + area).first

    unless area.blank?
        area = ActiveSupport::JSON.decode(area.value)

        if (area[role].present? && area[role][item].present?)
            return area[role][item].to_s == '1'
        end
    end

    return false
    end
end
