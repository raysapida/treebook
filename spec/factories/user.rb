require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }

    f.email { Faker::Internet.email }
    f.profile_name { Faker::Internet.user_name.gsub(/./, "_") }

    pass = Faker::Internet.password
    f.password { pass }
    f.password_confirmation { pass }
  end

  factory :album do |f|
    user
    #association :user, factory: :user

    f.title { Faker::Lorem.characters }
  end

  factory :picture do |f|
    user
    album

    f.caption { Faker::Lorem.sentence }
    f.description { Faker::Lorem.characters }
  end
end
