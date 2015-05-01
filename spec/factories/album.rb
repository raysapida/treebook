require 'faker'

FactoryGirl.define do
  factory :album do |f|
    association :user, factory: :user

    f.title { Faker::Lorem.characters }
  end
end
