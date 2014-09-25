class Document < ActiveRecord::Base
	has_attached_file :attachment
	
	validates_attachment_size :attachment, :less_than => 5.megabytes
	validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
