class Api::V1::Front::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render json: @categories, status: :ok
  end
end
