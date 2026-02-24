require 'faker'

FactoryBot.define do
  factory :status do 
    association :user, factory: :user

    content { Faker::Lorem.sentence }
  end
end
