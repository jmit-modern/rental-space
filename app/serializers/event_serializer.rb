class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :price_type, :cancellation_deadline, :site_url, :status, :starting_at, :ending_at, :contact, :space, :language_id, :language, :category_id, :category
  attribute :owner, if: :admin?

  belongs_to :space
  belongs_to :language
  belongs_to :category
  has_many :event_images

  def owner
    {
      id: object.user.id,
      username: object.user.username,
      full_name: [object.user.first_name, object.user.last_name].join(" "),
      description: object.user.description,
      email: object.user.email,
      created_at: object.user.created_at,
    }
  end

  def status
    Event.statuses[object.status]
  end

  def price_type
    Event.price_types[object.price_type]
  end

  def admin?
    true
  end
end
