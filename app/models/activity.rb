class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :targetable, polymorphic: true
	
	self.per_page = 5
	
	def self.for_user(user, options={}) 
		options[:page] ||= 1
		friend_ids = user.friends.map(&:id).push(user.id)
		collection = where("user_id in (?)", friend_ids).
			order("created_at desc")
		if options[:since] && !options[:since].blank? 
			since = DateTime.strptime( options[:since], '%s' )
			collection = collection.where("created_at > ?", since) if since
		end
		collection.page(options[:page])
	end
	
	def user_name 
		user.full_name
	end
	
	def profile_name 
		user.profile_name
	end
	
	def as_json(options={}) 
		super(
				only: [:action, :id, :targetable_id, :targetable_type, :created_at, :id],
				include: :targetable,
				methods: [:user_name, :profile_name]
			).merge(options)
	end
end
