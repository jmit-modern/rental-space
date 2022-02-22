require "faker"
SpaceImage.destroy_all

urls = [
  "https://cdnspacemarket.com/uploads/attachments/787106/image.jpg?fit=crop&width=1200&height=800&bg-color=9c9c9c",
  "https://cdnspacemarket.com/uploads/attachments/750266/image.jpg?fit=crop&width=1200&height=800&bg-color=9c9c9c",
  "https://cdnspacemarket.com/uploads/attachments/750267/image.jpg?fit=crop&width=1200&height=800&bg-color=9c9c9c",
  "https://cdnspacemarket.com/uploads/drawings/8581/image.jpg?fit=crop&width=1200&height=800&bg-color=9c9c9c",
  "https://cdnspacemarket.com/uploads/attachments/785459/image.jpg?fit=crop&width=1200&height=800&bg-color=9c9c9c",
  "https://cdnspacemarket.com/uploads/attachments/727672/image.jpg?fit=crop&width=1200&height=800&bg-color=9c9c9c",
  "https://cdnspacemarket.com/uploads/attachments/368345/image.jpg?fit=crop&width=1200&height=800&bg-color=9c9c9c",
]

3.times do
  spaces = Space.all
  spaces.map do |space|
    space.space_images.create!(
      space: space,
      image_type: rand(0..1),
      url: urls.sample,
      file_name: nil,
      caption: nil,
    )
  end
end
