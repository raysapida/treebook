require 'faker'

FactoryBot.define do
  factory :user do 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    email { Faker::Internet.email }
    profile_name { Faker::Internet.user_name.gsub(/[.]/, "_") }

    pass = Faker::Internet.password
    password { pass }
    password_confirmation { pass }
  end
end
