require "faker"
Space.destroy_all

names = [
  "【新規オープン】24時間使用可能！JR八王子駅から徒歩5分のダンス・ヨガスタジオ",
  "〈エクセルシオール朝霞台〉グランドOPEN【朝霞台駅5分】📷✨ママ会/女子会/デート💖/宅飲み🍻/鑑賞会",
  "【オープン記念 60%OFF！】コロナ対策完備/渋谷10分/コーヒー飲み放題!/リラックス部屋🌿/Wi-fi完備/ワークスペース",
  "【戸建/1棟貸/昭和レトロ/古民家】撮影会/コスプレ/女子会/会議などに",
  "古民家『禅』フルリノベ、お洒落なアイランドキッチンで料理会、女子会、BBQ、ミーティング、会議、飲み会利用",
]

30.times do
  prefecture = Prefecture.find(Prefecture.ids.sample)
  country = Country.find(Country.ids.sample)
  category = Category.find(Category.ids.sample)
  user = User.find(User.user_type_space_owner.ids.sample)
  Space.create!(
    user: user,
    name: names.sample,
    description: Faker::Lorem.sentence,
    space_type: rand(0..3),
    address1: Faker::Address.full_address,
    address2: Faker::Address.secondary_address,
    address3: Faker::Address.city,
    prefecture: prefecture,
    country: country,
    category: category,
    zip_code: Faker::Address.zip_code,
    url: "",
    gps: Faker::Lorem.paragraph,
    price: Faker::Commerce.price * 1000,
    cancellation_deadline: 48,
    capacity: rand(0..50),
    language: Faker::Lorem.paragraph,
    facility: Faker::Lorem.paragraph,
    lodging: Faker::Lorem.paragraph,
    loud_volume: Faker::Lorem.paragraph,
    cooking: Faker::Lorem.paragraph,
    wifi: Faker::Lorem.paragraph,
    parking: Faker::Lorem.paragraph,
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude,
    status: 1,
  )
end
