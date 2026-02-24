require 'faker'

FactoryBot.define do
  factory :album do
    association :user, factory: :user

    title { Faker::Lorem.characters }
  end
end
