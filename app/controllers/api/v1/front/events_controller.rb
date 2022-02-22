class Api::V1::Front::EventsController < ApplicationController
  before_action :authorize_request, except: %i[index show]
  before_action :filter_params, only: %i[index]
  before_action :find_event, except: %i[create index show new]
  before_action :has_permission, except: %i[index show new create]

  # GET /api/v1/events or /api/v1/events.json
  def index
    @events = EventServices::Search.call(filter_params)
    @events = @events.paginate(page: params[:page], per_page: per_page)
    render json: @events, meta: pagination_dict(@events), status: :ok
  end

  # GET /api/v1/events/1 or /api/v1/events/1.json
  def show
    begin
      @event = Event.find(params[:id])
    rescue => e
      logger.info e
      return render json: { message: "Event not found" }, status: :not_found
    end
    render json: @event
  end

  def new
    @event = Event.new
    @event.event_images.build
  end

  # POST /api/v1/events or /api/v1/events.json
  def create
    @event = Event.new(event_params)
    if @event.save
      render json: { message: "Event Created Successfully" }, status: :created
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/events/1 or /api/v1/events/1.json
  def update
    unless @event.update(event_params)
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: @event, status: :ok
    end
  end

  def add_image
    begin
      obj = AwsService::upload(params[:file]) if params[:file].present?
      @event_image = Event.find(params[:id]).event_images.new({ url: obj.public_url })
      unless @event_image.save
        render json: { errors: @event_image.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @event_image, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Add Image Failed" }, status: :unprocessable_entity
    end
  end

  def remove_image
    begin
      @event_image = EventImage.find(params[:image_id])
      if @event_image.url.include? "amazonaws.com/"
        key = @event_image.url.split("amazonaws.com/")[1]
        S3_BUCKET.object(key).delete
      end

      unless @event_image.destroy
        render json: { errors: @event_image.errors.full_messages },
               status: :unprocessable_entity
      else
        render json: @event_image, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Remove Image Failed" }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/events/1 or /api/v1/events/1.json
  def destroy
    unless @event.destroy
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: @event, status: :ok
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def event_params
    params[:event][:event_images_attributes] = params[:event_images]
    params.require(:event).permit(
      :id,
      :name,
      :description,
      :price,
      :price_type,
      :category_id,
      :language_id,
      :user_id,
      :site_url,
      :starting_at,
      :ending_at,
      :status,
      :contact,
      :cancellation_deadline,
      event_images_attributes: [:id, :image_type, :url, :file_name, :caption],
    )
  end

  # Event callbacks to share common setup or constraints between actions.
  def find_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Event not found" }, status: :not_found
  end

  def per_page
    params[:per_page] ? params[:per_page] : Event.per_page
  end

  def has_permission
    render json: { message: "Permission denied" }, status: :forbidden unless @event.user == @current_user
  end

  def filter_params
    params.slice(:starting_at, :ending_at, :prefecture, :category, :user_id, :price_from, :price_to, :keywords, :status)
  end
end
