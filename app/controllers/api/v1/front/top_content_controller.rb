class Api::V1::Front::TopContentController < ApplicationController
  before_action :set_query_params

  def new_spaces
    @new_spaces = Space.all.with_limit(@params["limit"])
    render json: @new_spaces, each_serializer: SpaceSerializer, status: :ok
  end

  def pickup_spaces
    @pickup_spaces = Space.all.with_limit(@params["limit"])
    render json: @pickup_spaces, each_serializer: SpaceSerializer, status: :ok
  end

  private

  def set_query_params
    @params = request.query_parameters
  end
end
