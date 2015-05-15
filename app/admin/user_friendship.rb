ActiveAdmin.register UserFriendship do
  includes :user, :friend
  permit_params :user_id, :state, :friend_id

  index do
    column :state
    column :updated_at
    column :user
    column :friend
    actions
  end

  filter :state, as: :string, label: 'State'
end
