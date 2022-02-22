require "faker"
Expert.destroy_all

experts = User.user_type_expert

experts.each do |expert|
  language = Language.find(Language.ids.sample)
  category = Category.find(Category.ids.sample)
  Expert.create!([{
    user: expert,
    skill_title: Faker::Lorem.paragraph,
    description: Faker::Lorem.paragraph(sentence_count: 4),
    price: Faker::Commerce.price * 1000,
    cancellation_deadline: 48,
    language: language,
    category: category,
    url: nil,
  }])
end
