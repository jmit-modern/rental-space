class Api::V1::Front::SpacesController < ApplicationController
  before_action :authorize_request, except: %i[index show space_types related get_plan]
  before_action :filter_params, only: %i[index]
  before_action :find_space, except: %i[index create space_types]
  before_action :has_permission, except: %i[index show related new create space_types get_plan]
  before_action :plan_params, only: %i[add_plan update_plan]

  # GET /api/v1/front/spaces or /api/v1/front/spaces.json
  def index
    @spaces = SpaceServices::Search.call(filter_params)
    @spaces = @spaces.paginate(page: params[:page], per_page: per_page)
    render json: @spaces, each_serializer: SpaceSerializer, meta: pagination_dict(@spaces), status: :ok
  end

  # GET /api/v1/front/spaces/1 or /api/v1/front/spaces/1.json
  def show
    render json: @space, status: :ok
  end

  def related
    @related_spaces = Space.where(category_id: @space.category_id).sample(6)
    render json: @related_spaces, each_serializer: SpaceSerializer, status: :ok
  end

  # GET /api/v1/front/spaces/new
  def new
    @space = Space.new
    @event.space_images.build
  end

  # GET /api/v1/front/spaces/1/edit
  def edit
  end

  # POST /api/v1/front/spaces or /api/v1/front/spaces.json
  def create
    @space = Space.new(space_params)

    if @space.save
      render json: @space, status: :created
    else
      render json: { errors: @space.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/front/spaces/1 or /api/v1/front/spaces/1.json
  def update
    unless @space.update(space_params)
      render json: { errors: @space.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: @space, status: :ok
    end
  end

  def add_image
    begin
      obj = AwsService::upload(params[:file]) if params[:file].present?
      @space_image = @space.space_images.new({ url: obj.public_url })
      unless @space_image.save
        render json: { errors: @space_image.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @space_image, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Add Image Failed" }, status: :unprocessable_entity
    end
  end

  def remove_image
    begin
      @space_image = SpaceImage.find(params[:image_id])

      if @space_image.url.include? "amazonaws.com/"
        key = @space_image.url.split("amazonaws.com/")[1]
        S3_BUCKET.object(key).delete
      end

      unless @space_image.destroy
        render json: { errors: @space_image.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @space_image, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Remove Image Failed" }, status: :unprocessable_entity
    end
  end

  def get_plan
    @space_plans = SpacePlan.where(space_id: params[:id])
    @space_plans = @space_plans.where("minimum_time <= ?", params[:use_time]) if params[:use_time].present?
    render json: @space_plans, status: :ok
  end

  def add_plan
    begin
      @space_plan = @space.space_plans.new(plan_params)
      unless @space_plan.save
        render json: { errors: @space_plan.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @space_plan, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Add Plan Failed" }, status: :unprocessable_entity
    end
  end

  def update_plan
    begin
      @space_plan = SpacePlan.find(params[:plan_id])
      @space_plan.assign_attributes(plan_params)
      unless @space_plan.save
        render json: { errors: @space_plan.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @space_plan, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Update Plan Failed" }, status: :unprocessable_entity
    end
  end

  def remove_plan
    begin
      @space_plan = SpacePlan.find(params[:plan_id])

      unless @space_plan.destroy
        render json: { errors: @space_plan.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @space_plan, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Remove Plan Failed" }, status: :unprocessable_entity
    end
  end

  def update_facilities
    begin
      @space.facilities.clear
      params[:facilities].each do |i|
        @space.facilities << Facility.find(i)
      end

      render json: @space, status: :ok
    rescue => e
      logger.info e
      return render json: { message: "Update Facilities Failed" }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/front/spaces/1 or /api/v1/front/spaces/1.json
  def destroy
    unless @space.destroy
      render json: { errors: @space.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: @space, status: :ok
    end
  end

  def space_types
    render json: Space.space_types, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_space
    @space = Space.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Space not found" }, status: :not_found
  end

  def has_permission
    render json: { message: "Permission denied" }, status: :forbidden unless @space.user == @current_user
  end

  # Only allow a list of trusted parameters through.
  def space_params
    params[:space][:space_images_attributes] = params[:space_images]
    params.require(:space).permit(
      :id,
      :name,
      :description,
      :lodging,
      :loud_volume,
      :cooking,
      :wifi,
      :parking,
      :capacity,
      :price,
      :address1, :lat, :lng, :address2, :address3,
      :category_id,
      :space_type,
      :contact,
      :cancellation_deadline,
      :user_id,
      :status,
      space_images_attributes: [:id, :image_type, :url, :file_name, :caption],
    )
  end

  def per_page
    params[:per_page] ? params[:per_page] : Space.per_page
  end

  def plan_params
    params.permit(:name, :minimum_time, :price)
  end

  def filter_params
    params.slice(:starting_at, :ending_at, :user_id, :category, :area, :price_from, :price_to, :keywords, :status, :sort)
  end
end
