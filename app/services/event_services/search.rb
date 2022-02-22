class EventServices::Search < ApplicationService
  attr_reader :params

  def initialize(params)
    @starting_at = params[:starting_at]
    @ending_at = params[:ending_at]
    @prefecture_id = params[:prefecture]
    @category_id = params[:category]
    @user_id = params[:user_id]
    @price_from = params[:price_from]
    @price_to = params[:price_to]
    @keywords = params[:keywords]
    @status = params[:status]
  end

  def call
    @events = Event.all
    if @starting_at.present?
      @events = @events.where("starting_at >= ? ", @starting_at)
    else
      @events = @events.where("starting_at >= ? ", Time.zone.now)
    end
    @events = @events.where("ending_at <= ?", @ending_at) if @ending_at.present?
    @events = @events.filter_by_prefecture(@prefecture_id) if @prefecture_id.present?
    @events = @events.where(user_id: @user_id) if @user_id.present?
    @events = @events.where(category_id: @category_id) if @category_id.present?
    @events = @events.where("name ILIKE :search OR description ILIKE :search ", search: "%" + @keywords + "%") if @keywords.present?
    @events = @events.where("price >= ? ", @price_from) if @price_from.present?
    @events = @events.where("price <= ? ", @price_to) if @price_to.present?
    @events = @events.status_active if @status.present? && @status.to_i == Event.statuses[:active]
    return @events
  end
end
