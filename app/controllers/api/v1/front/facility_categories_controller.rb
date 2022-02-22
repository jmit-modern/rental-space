class Api::V1::Front::FacilityCategoriesController < ApplicationController
  def index
    @facility_categories = FacilityCategory.all
    render json: @facility_categories, each_serializer: FacilityCategorySerializer, status: :ok
  end
end
