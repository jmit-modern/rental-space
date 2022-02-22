class Api::V1::Admin::EventsController < ApplicationController
  before_action :authorize_request
  before_action :admin_only
  before_action :filter_params, only: %i[index]
  before_action :find_event, except: %i[index statuses]

  # GET /api/v1/admin/events or /api/v1/admin/events.json
  def index
    @events = EventServices::Search.call(filter_params)
    @events = @events.paginate(page: params[:page], per_page: per_page)
    render json: @events, each_serializer: EventSerializer, meta: pagination_dict(@events), status: :ok
  end

  # GET /api/v1/admin/events/1 or /api/v1/admin/events/1.json
  def show
    render json: @event, status: :ok
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

  def statuses
    render json: Event.statuses, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Event not found" }, status: :not_found
  end

  def per_page
    params[:per_page] ? params[:per_page] : Event.per_page
  end

  def filter_params
    params.slice(:starting_at, :ending_at, :prefecture, :category, :user_id, :price_from, :price_to, :keywords)
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.permit(:status)
  end
end
