require "faker"
User.destroy_all

photos = [
  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
  "https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
  "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
  "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
]

users = []
10.times do |i|
  expert = {
    username: "expert#{i}",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "expert#{i}@test.com",
    password_digest: "12345678",
    user_type: User.user_types[:expert],
    card_number: "",
    photo: photos.sample,
    status: 1,
    last_login: nil,
    description: Faker::Lorem.paragraph,
  }
  users << expert
end

5.times do |i|
  space_owner = {
    username: "owner#{i}",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "owner#{i}@test.com",
    password_digest: "12345678",
    user_type: User.user_types[:space_owner],
    card_number: "",
    photo: photos.sample,
    status: 1,
    last_login: nil,
    description: Faker::Lorem.paragraph,
  }
  users << space_owner
end

default_user = {
  username: "test",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "test@test.com",
  password_digest: "12345678",
  user_type: 0,
  card_number: "",
  photo: photos.sample,
  status: 1,
  last_login: nil,
  description: Faker::Lorem.paragraph,
}

admin_user = {
  username: "himitsukichi",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "admin@himitsukichi.network",
  password_digest: "12341234",
  user_type: 3,
  card_number: "",
  photo: photos.sample,
  status: 1,
  last_login: nil,
  description: Faker::Lorem.paragraph,
}

users << default_user
users << admin_user

User.create!(users)
