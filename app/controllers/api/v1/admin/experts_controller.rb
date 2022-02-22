class Api::V1::Admin::ExpertsController < ApplicationController
  before_action :authorize_request
  before_action :admin_only
  before_action :filter_params, only: %i[index]
  before_action :find_expert, except: %i[index expert_types statuses]

  # GET /api/v1/experts or /api/v1/experts.json
  def index
    @experts = ExpertServices::Search.call(filter_params)
    @experts = @experts.paginate(page: params[:page], per_page: per_page)
    render json: @experts, meta: pagination_dict(@experts), status: :ok
  end

  # GET /api/v1/admin/experts/1 or /api/v1/admin/experts/1.json
  def show
    render json: @expert, status: :ok
  end

  # PATCH/PUT /api/v1/experts/1 or /api/v1/experts/1.json
  def update
    unless @expert.update(expert_params)
      render json: { errors: @expert.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: @expert, status: :ok
    end
  end

  private

  # Expert callbacks to share common setup or constraints between actions.
  def find_expert
    @expert = Expert.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Expert not found" }, status: :not_found
  end

  def per_page
    params[:per_page] ? params[:per_page] : Expert.per_page
  end

  def filter_params
    params.slice(:prefecture, :category, :price_from, :price_to, :keywords)
  end

  # Only allow a list of trusted parameters through.
  def expert_params
    params.permit(:status)
  end
end
