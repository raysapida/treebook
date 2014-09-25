class Document < ActiveRecord::Base
	has_attached_file :attachment
	
	attr_accessor :remove_attachment
	
	validates_attachment_size :attachment, :less_than => 5.megabytes
	validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
	
	before_save :perform_attachment_removal
	def perform_attachment_removal 
		if remove_attachment == '1' && !attachment.dirty? 
			self.attachment = nil
		end
	end
end
