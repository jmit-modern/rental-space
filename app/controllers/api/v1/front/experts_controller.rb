class Api::V1::Front::ExpertsController < ApplicationController
  before_action :authorize_request, except: %i[index create show new]
  before_action :filter_params, only: %i[index]
  before_action :find_expert, except: %i[create index show]
  before_action :has_permission, except: %i[index show new create]

  # GET /api/v1/experts or /api/v1/experts.json
  def index
    @experts = ExpertServices::Search.call(filter_params)
    @experts = @experts.paginate(page: params[:page], per_page: 5)
    render json: @experts, meta: pagination_dict(@experts), status: :ok
  end

  # GET /api/v1/experts/1 or /api/v1/experts/1.json
  def show
    begin
      @expert = Expert.find(params[:id])
    rescue => e
      logger.info e
      return render json: { message: "Expert not found" }, status: :not_found
    end
    render json: @expert
  end

  def new
    @expert = Expert.new
    @skills = @expert.build_skills
    @expert_skills = @expert.expert_skills.build
  end

  # POST /api/v1/experts or /api/v1/experts.json
  def create
    @expert = Expert.new(expert_params)
    if @expert.save
      render json: { message: "Expert Created Successfully" }, status: :created
    else
      render json: { errors: @expert.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/experts/1 or /api/v1/experts/1.json
  def update
    @expert.expert_skills.destroy_all
    expert_params[:skills_attributes].each do |skill_attr|
      if skill_attr["id"].present?
        skill = Skill.find(skill_attr["id"])
        @expert.skills << skill
      end
    end

    unless @expert.update(expert_params)
      render json: { errors: @expert.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: { message: "Expert Updated Successfully" }, status: :ok
    end
  end

  # DELETE /api/v1/experts/1 or /api/v1/experts/1.json
  def destroy
    @expert.destroy
  end

  private

  # Only allow a list of trusted parameters through.
  def expert_params
    params[:expert][:skills_attributes] = params[:skills]
    params.require(:expert).permit(:id, :skill_title, :description, :price, :cancellation_deadline, :language_id, :category_id, :url, skills_attributes: [:id, :name])
  end

  # Expert callbacks to share common setup or constraints between actions.
  def find_expert
    @expert = Expert.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Expert not found" }, status: :not_found
  end

  def has_permission
    render json: { message: "Permission denied" }, status: :forbidden unless @expert.user == @current_user
  end

  def filter_params
    params.slice(:prefecture, :category, :price_from, :price_to, :keywords)
  end
end
