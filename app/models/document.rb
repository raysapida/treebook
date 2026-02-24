class Document < ApplicationRecord
  has_one_attached :attachment do |attachable|
    attachable.variant :thumb,   resize_to_fill: [80, 80]
    attachable.variant :small,   resize_to_limit: [260, 180]
    attachable.variant :medium,  resize_to_limit: [300, 200]
    attachable.variant :large,   resize_to_limit: [800, 800]
  end

  attr_accessor :remove_attachment

  validates :attachment, content_type: /\Aimage\/.*\Z/, size: { less_than: 5.megabytes }, allow_blank: true

  before_save :perform_attachment_removal
  def perform_attachment_removal
    attachment.purge if remove_attachment == '1' && attachment.attached?
  end
end
