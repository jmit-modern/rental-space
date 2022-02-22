require "faker"
EventImage.destroy_all

urls = [
  "http://eventim.bold-themes.com/conference/wp-content/uploads/sites/6/2015/10/portfolio_08.jpg",
  "http://eventim.bold-themes.com/conference/wp-content/uploads/sites/6/2015/10/portfolio_10.jpg",
  "http://eventim.bold-themes.com/conference/wp-content/uploads/sites/6/2015/10/portfolio_07.jpg",
  "http://eventim.bold-themes.com/conference/wp-content/uploads/sites/6/2015/10/portfolio_06.jpg",
  "http://eventim.bold-themes.com/conference/wp-content/uploads/sites/6/2015/10/portfolio_05.jpg",
  "http://eventim.bold-themes.com/conference/wp-content/uploads/sites/6/2015/10/portfolio_03.jpg",
  "http://eventim.bold-themes.com/conference/wp-content/uploads/sites/6/2015/10/portfolio_10.jpg",
]

3.times do
  events = Event.all
  events.map do |event|
    event.event_images.create!(
      event: event,
      image_type: rand(0..1),
      url: urls.sample,
      file_name: nil,
      caption: nil,
    )
  end
end
