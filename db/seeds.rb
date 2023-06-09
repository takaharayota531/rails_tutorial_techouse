# frozen_string_literal: true

User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
User.create!(name: 'takahara.yota@gmail.com',
             email: 'takahara.yota@gmail.com',
             password: 'takahara.yota@gmail.com',
             password_confirmation: 'takahara.yota@gmail.com',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
99.times do |n|
  name = Faker::Name.name
  email = "example#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(
    name:,
    email:,
    password:,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.order(:created_at).take(6)

50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each do |user|
    user.microposts.create!(content:)
  end
end

users = User.all
user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
