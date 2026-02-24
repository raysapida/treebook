module ApplicationHelper

  def bootstrap_active_storage_picture(form, attachment_name)
    attachment = form.object.public_send(attachment_name)
    if attachment.attached?
      content_tag(:div, class: 'control-group') do
        content_tag(:label, "Current #{attachment_name.to_s.titleize}", class: 'col-sm-2 control-label') +
          content_tag(:div, class: 'col-sm-10 controls') do
          image_tag attachment.variant(:small)
        end
      end
    end
  end

  def status_document_link(status)
    if status.document&.attachment&.attached?
      content_tag(:span, 'Attachment', class: 'label label-info') +
        link_to(status.document.attachment.filename, url_for(status.document.attachment))
    end
  end

  def can_display_status?(status)
    signed_in? && !current_user.has_blocked?(status.user) || !signed_in?
  end

  def flash_class(type)
    case type
    when :alert
      'alert-danger'
    when :notice
      'alert-success'
    else
      ''
    end
  end

  def avatar_profile_link(user, image_options={}, html_options={})
    link_to(image_tag(user.gravatar_url, image_options), profile_path(user.profile_name), html_options)
  end

  def page_header(&block)
    content_tag(:div, capture(&block), class: 'page-header')
  end
end
