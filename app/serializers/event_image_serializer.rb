class EventImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :image_type, :file_name, :caption

  belongs_to :event
end
