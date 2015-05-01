require 'faker'

FactoryGirl.define do
  factory :picture do |f|
    association :album, factory: :album

    f.caption { Faker::Lorem.sentence }
    f.description { Faker::Lorem.characters }
  end
end
