# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Prefecture.destroy_all

Prefecture.create!([
  { id: 1, name: "北海道" },
  { id: 2, name: "岩手県" },
  { id: 3, name: "茨城県" },
  { id: 4, name: "群馬県" },
  { id: 5, name: "埼玉県" },
  { id: 6, name: "千葉県" },
  { id: 7, name: "東京都" },
  { id: 8, name: "神奈川県" },
  { id: 9, name: "富山県" },
  { id: 10, name: "石川県" },
  { id: 11, name: "長野県" },
  { id: 12, name: "静岡県" },
  { id: 13, name: "愛知県" },
  { id: 14, name: "三重県" },
  { id: 15, name: "京都府" },
  { id: 16, name: "大阪府" },
  { id: 17, name: "兵庫県" },
  { id: 18, name: "奈良県" },
  { id: 19, name: "和歌山県" },
  { id: 20, name: "福岡県" },
  { id: 21, name: "宮崎県" },
  { id: 22, name: "沖縄県" },
])
