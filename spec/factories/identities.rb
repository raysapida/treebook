FactoryBot.define do
  factory :identity do
    user { nil }
    provider { "MyString" }
    accesstoken { "MyString" }
    refreshtoken { "MyString" }
    uid { "MyString" }
    name { "MyString" }
    email { "MyString" }
    nickname { "MyString" }
    image { "MyString" }
    phone { "MyString" }
    urls { "MyString" }
  end
end
