SpaceFacility.destroy_all

spaces = Space.all

spaces.each do |space|
  facilities = Facility.all.sample(60)
  facilities.each do |facility|
    SpaceFacility.create!(
      space: space,
      facility: facility,
    )
  end
end
