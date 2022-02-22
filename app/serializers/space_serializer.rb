class SpaceSerializer < ActiveModel::Serializer
  attributes :id, :owner, :name, :description, :space_type, :address1, :address2, :address3, :prefecture, :country, :zip_code, :url, :gps, :price, :capacity, :cancellation_deadline, :language, :lodging, :loud_volume, :cooking, :wifi, :parking, :created_at, :category_id, :featured_image, :lng, :lat, :status

  belongs_to :country
  belongs_to :prefecture
  belongs_to :category
  has_many :space_images
  has_many :space_plans
  has_many :facilities

  def owner
    {
      id: object.user.id,
      username: object.user.username,
      full_name: [object.user.first_name, object.user.last_name].join(" "),
      description: object.user.description,
      photo: object.user.photo,
      phone: object.user.phone,
      email: object.user.email,
      created_at: object.user.created_at,
    }
  end

  def status
    Space.statuses[object.status]
  end
end
