class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :omniauthable

  has_many :statuses
  has_many :user_friendships
  has_many :friends, -> { where(user_friendships: { state: 'accepted'}) }, through: :user_friendships

  has_many :pending_user_friendships,
    -> { where user_friendships: { state: 'pending' } },
    class_name: 'UserFriendship',
    foreign_key: :user_id

  has_many :pending_friends,
    -> { where user_friendships: { state: 'pending' } },
    through: :pending_user_friendships,
    source: :friend

  has_many :requested_user_friendships,
    -> { where user_friendships: { state: 'requested' } },
    class_name: 'UserFriendship',
    foreign_key: :user_id

  has_many :requested_friends,
    -> { where user_friendships: { state: 'requested' } },
    through: :requested_user_friendships,
    source: :friend

  has_many :blocked_user_friendships,
    -> { where user_friendships: { state: 'blocked' } },
    class_name: 'UserFriendship',
    foreign_key: :user_id

  has_many :blocked_friends,
    -> { where user_friendships: { state: 'blocked' } },
    through: :blocked_user_friendships,
    source: :friend

  has_many :accepted_user_friendships,
    -> { where user_friendships: { state: 'accepted' } },
    class_name: 'UserFriendship',
    foreign_key: :user_id

  has_many :accepted_friends,
    -> { where user_friendships: { state: 'accepted' } },
    through: :accepted_user_friendships,
    source: :friend

  has_attached_file :avatar, styles: {
    large: '800x800>', medium: '300x200>', small: '260x180>', thumb: '80x80#'
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :profile_name, presence: true,
    uniqueness: true,
    format: {
      with: /\A[a-zA-Z0-9_\-]+\z/,
      message: 'Must be formatted correctly.'
    }
    validates :email, email: true, uniqueness: true, allow_blank: true, if: :email_changed?
    validates_presence_of   :email, if: :email_required?
    validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
    validates_presence_of     :password, if: :password_required?
    validates_confirmation_of :password, if: :password_required?
    validates_length_of       :password, within: Devise.password_length, allow_blank: true

    has_many :albums
    has_many :pictures
    has_many :activities
    has_many :identities

    def full_name
      first_name + ' ' + last_name
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

    def create_activity(item, action)
      activity = activities.new
      activity.targetable = item
      activity.action = action
      activity.save
      activity
    end

    def password_required?
      return false if email.blank?
      !persisted? || !password.nil? || !password_confirmation.nil?
    end

    def email_required?
      true
    end

    def twitter
      identities.where( :provider => "twitter" ).first
    end

    def twitter_client
      @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
    end

    def facebook
      identities.where( :provider => "facebook" ).first
    end

    def facebook_client
      @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
    end

    def instagram
      identities.where( :provider => "instagram" ).first
    end

    def instagram_client
      @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
    end

    def google_oauth2
      identities.where( :provider => "google_oauth2" ).first
    end

    def google_oauth2_client
      if !@google_oauth2_client
        @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
        @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
      end
      @google_oauth2_client
    end

    def is_admin?
      self.email && ENV['ADMIN_EMAILS'].to_s.include?(self.email)
    end

end
