require "faker"
Event.destroy_all

20.times do
  language = Language.find(Language.ids.sample)
  space = Space.find(Space.ids.sample)
  category = Category.find(Category.ids.sample)
  user = User.find(User.ids.sample)
  Event.create!(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence,
    price: 5000,
    price_type: 0,
    starting_at: Faker::Time.between(from: Date.today + 1, to: Date.today + 4),
    ending_at: Faker::Time.between(from: Date.today + 5, to: Date.today + 6),
    cancellation_deadline: 48,
    language: language,
    space: space,
    category: category,
    user: user,
    status: 1,
    contact: Faker::Lorem.sentence,
    site_url: "",
  )
end
