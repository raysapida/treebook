class Album < ApplicationRecord
  belongs_to :user
  has_many :pictures

  validates_presence_of :title
end
