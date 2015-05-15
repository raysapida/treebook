ActiveAdmin.register Status do
  actions :all, except: [:update]
  includes :user
  permit_params :content, :user_id

  index do
    column :content
    column :user
    actions
  end
end
