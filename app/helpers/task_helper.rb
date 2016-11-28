module TaskHelper
  def check_value(p, v, t, f = '')
    (p == v) ? t : f
  end

  def check_when(p)
    if p.present?
      begin
        DateTime.parse(p[:when]).strftime('%A %d %B %Y - %H:%m')
      rescue ArgumentError
        nil
      end
    end
  end

  def check_weekday(p, v)
    if p.present?
      check_value params[:repeat_on][v], v, 'checked'
    else
      nil
    end
  end

  def status(s, a = 'color')
    case s
      when 'done'
        return (a == 'color') ? 'teal' : material_icon.done_all
      when 'to_do' 
        return (a == 'color') ? 'orange' : material_icon.warning
      when 'late'
        return (a == 'color') ? 'deep-orange' : material_icon.assignment_late
    end
  end
end