class FacilityCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :facilities

  has_many :facilities
end
