require 'faker'

include ActionDispatch::TestProcess

FactoryBot.define do
  factory :picture do
    association :album, factory: :album
    association :user, factory: :user

    asset { File.new("#{Rails.root}/spec/images/rails.png") }

    caption { Faker::Lorem.sentence }
    description { Faker::Lorem.characters }
  end
end
