DEFAULT_INSECURE_PASSWORD = 'mikethefrog1'

User.create({
  first_name: "Mike",
  last_name: "The Frog",
  profile_name: "mikethefrog",
  email: "mike@teamtreehouse.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Jason",
  last_name: "Seifer",
  profile_name: "jason",
  email: "jason@teamtreehouse.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Jim",
  last_name: "Hoskins",
  profile_name: "jim",
  email: "jim@teamtreehouse.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Nick",
  last_name: "Pettit",
  profile_name: "nick",
  email: "nick@teamtreehouse.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Ryan",
  last_name: "Carson",
  profile_name: "ryan",
  email: "ryan@teamtreehouse.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

jason = User.find_by_email('jason@teamtreehouse.com')
jim   = User.find_by_email('jim@teamtreehouse.com')
nick  = User.find_by_email('nick@teamtreehouse.com')
mike  = User.find_by_email('mike@teamtreehouse.com')
ryan  = User.find_by_email('ryan@teamtreehouse.com')

seed_user = jason

seed_user.statuses.create(content: "Hello, world!")
jim.statuses.create(content: "Hi, I'm Jim")
nick.statuses.create(content: "Hello from the internet!")
mike.statuses.create(content: "I want to learn html javapress")
ryan.statuses.create(content: "Treebook is awesome!")

# UserFriendship.request(seed_user, jim).accept!
# UserFriendship.request(seed_user, nick).block!
# UserFriendship.request(seed_user, mike)
# UserFriendship.request(ryan, seed_user)

10.times do |n|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  profile_name = Faker::Internet.user_name.gsub(/[.]/, "_")
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(first_name:  first_name,
               last_name: last_name,
               profile_name: profile_name,
               email: email,
               password:              password,
               password_confirmation: password,)
end

fake_people = User.last(10)
20.times do
    content = Faker::Lorem.sentence(5)
      fake_people.each { |user| user.statuses.create!(content: content) }
end

