class SpacePlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :minimum_time, :price

  belongs_to :space
end
