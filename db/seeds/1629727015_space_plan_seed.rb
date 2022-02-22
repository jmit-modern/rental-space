require "faker"
SpacePlan.destroy_all

3.times do
  spaces = Space.all
  spaces.map do |space|
    space.space_plans.create!(
      space: space,
      name: Faker::Lorem.sentence,
      minimum_time: rand(1..10),
      price: Faker::Commerce.price * 1000,
    )
  end
end
