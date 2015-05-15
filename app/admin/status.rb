ActiveAdmin.register Status do
  includes :user
  permit_params :content, :user_id, :id

  index do
    column :content
    column :user
    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end
end
