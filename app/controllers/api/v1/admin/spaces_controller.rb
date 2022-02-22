class Api::V1::Admin::SpacesController < ApplicationController
  before_action :authorize_request
  before_action :admin_only
  before_action :filter_params, only: %i[index]
  before_action :find_space, except: %i[index space_types statuses]

  # GET /api/v1/admin/spaces or /api/v1/admin/spaces.json
  def index
    @spaces = SpaceServices::Search.call(filter_params)
    @spaces = @spaces.paginate(page: params[:page], per_page: per_page)
    render json: @spaces, each_serializer: SpaceSerializer, meta: pagination_dict(@spaces), status: :ok
  end

  # GET /api/v1/admin/spaces/1 or /api/v1/admin/spaces/1.json
  def show
    render json: @space, status: :ok
  end

  # PATCH/PUT /api/v1/spaces/1 or /api/v1/spaces/1.json
  def update
    unless @space.update(space_params)
      render json: { errors: @space.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: @space, status: :ok
    end
  end

  def space_types
    render json: Space.space_types, status: :ok
  end

  def statuses
    render json: Space.statuses, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_space
    @space = Space.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Space not found" }, status: :not_found
  end

  def per_page
    params[:per_page] ? params[:per_page] : Space.per_page
  end

  def filter_params
    params.slice(:user_id, :category, :area, :price_from, :price_to, :keywords)
  end

  # Only allow a list of trusted parameters through.
  def space_params
    params.permit(:status)
  end
end
