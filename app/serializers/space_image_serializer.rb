class SpaceImageSerializer < ActiveModel::Serializer
  attributes :id, :url

  belongs_to :space
end
