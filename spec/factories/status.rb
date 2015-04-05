require 'faker'

FactoryGirl.define do
  factory :status do |f|
    association :user, factory: :user

    f.content { Faker::Lorem.sentence }
  end
end
