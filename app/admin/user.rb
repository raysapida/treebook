ActiveAdmin.register User do
  permit_params :email, :profile_name, :last_name, :first_name

  index do
    column :email
    column :profile_name
    column :first_name
    column :last_name
    actions
  end
end
