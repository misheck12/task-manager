module ApplicationHelper
  def error_tag(model, attribute)
    if model.errors.has_key? attribute
      content_tag(
        :div,
        model.errors[attribute].first,
        class: 'error_message'
      )
    end
  end

  def page_active?(page, controller_name)
    if page === controller_name
      'active'
    end
  end

  def format(datetime)
    datetime.strftime('%m/%d/%Y at %H:%M')
  end
  def user_photo(thumb = false)
    if current_user.photo.present?
      if thumb
        current_user.photo.thumb.url
      else
        current_user.photo_url
      end
    else
      '/assets/material/images/user.png'
    end
  end

  def user_background(thumb = false)
    if current_user.background.present?
      if thumb
        current_user.background.thumb.url
      else
        current_user.background_url
      end
    else
      '/assets/material/images/user-img-background.jpg'
    end
  end
end
