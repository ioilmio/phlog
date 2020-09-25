# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
  name = Faker::Name.name
  fullname = Faker::Name.name
  email = "user-#{n + 1}@mail.com"
  password = 'password'
  User.create!(username: name,
               fullname: fullname,
               email: email, password: password,
               password_confirmation: password)
end
users = User.order(:created_at).take(6)
5.times do
  content = Faker::Lorem.sentence
  users.each { |user| user.opinions.create!(content: content) }
end

users = User.all
user = users.first
following = users[5..12]
followers = users[1..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
