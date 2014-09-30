class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	has_many :statuses
	has_many :user_friendships
	has_many :friends, -> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships
	
	has_many :pending_user_friendships, 
              -> { where user_friendships: { state: "pending" } }, 
                 class_name: 'UserFriendship',
									foreign_key: :user_id
	
	has_many :pending_friends, 
              -> { where user_friendships: { state: "pending" } }, 
                 through: :pending_user_friendships,
                 source: :friend
	
	has_many :requested_user_friendships, 
              -> { where user_friendships: { state: "requested" } }, 
                 class_name: 'UserFriendship',
									foreign_key: :user_id
	
	has_many :requested_friends, 
              -> { where user_friendships: { state: "requested" } }, 
                 through: :requested_user_friendships,
                 source: :friend
	
	has_many :blocked_user_friendships, 
              -> { where user_friendships: { state: "blocked" } }, 
                 class_name: 'UserFriendship',
									foreign_key: :user_id
	
	has_many :blocked_friends, 
              -> { where user_friendships: { state: "blocked" } }, 
                 through: :blocked_user_friendships,
                 source: :friend
	
	has_many :accepted_user_friendships, 
              -> { where user_friendships: { state: "accepted" } }, 
                 class_name: 'UserFriendship',
									foreign_key: :user_id
	
	has_many :accepted_friends, 
              -> { where user_friendships: { state: "accepted" } }, 
                 through: :accepted_user_friendships,
                 source: :friend
	
	has_attached_file :avatar, styles: {
			large: "800x800>", medium: "300x200>", small: "260x180>", thumb: "80x80#"
		}
	
	validates :first_name, presence: true
	
	validates :last_name, presence: true
	
	validates :profile_name, presence: true,
														uniqueness: true,
														format: {
																with: /\A[a-zA-Z0-9_\-]+\z/,
																message: 'Must be formatted correctly.'
															}
	has_many :albums
	has_many :pictures
	
	def full_name 
		first_name + " " + last_name
	end
	
	def to_param 
		profile_name
	end
	
	def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}"
  end

	def has_blocked?(other_user) 
		blocked_friends.include?(other_user)
	end
end
