require 'faker'

FactoryBot.define do
  factory :picture do
    association :album, factory: :album
    association :user, factory: :user

    caption { Faker::Lorem.sentence }
    description { Faker::Lorem.characters }

    after(:build) do |picture|
      picture.asset.attach(
        io: File.open("#{Rails.root}/spec/images/rails.png"),
        filename: 'rails.png',
        content_type: 'image/png'
      )
    end
  end
end
