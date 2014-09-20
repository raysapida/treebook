class UserFriendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
	
	state_machine :state, initial: :pending do 
		
	end
	
end
