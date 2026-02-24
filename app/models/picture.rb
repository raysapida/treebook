class Picture < ApplicationRecord
  belongs_to :album
  belongs_to :user

  validates_presence_of :album_id
  has_one_attached :asset do |attachable|
    attachable.variant :thumb,   resize_to_fill: [80, 80]
    attachable.variant :small,   resize_to_limit: [260, 180]
    attachable.variant :medium,  resize_to_limit: [300, 200]
    attachable.variant :large,   resize_to_limit: [800, 800]
  end
  validates :asset, attached: true, on: :create
  validates :asset, content_type: /\Aimage\/.*\Z/

  def to_s
    caption? ? caption : "Picture"
  end
end
