ActiveAdmin.register User do
  permit_params :email, :profile_name, :last_name, :first_name

  index do
    column :email
    column :profile_name
    column :first_name
    column :last_name
    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end
end
