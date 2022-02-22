class ExpertServices::Search < ApplicationService
  attr_reader :params

  def initialize(params)
    @prefecture_id = params[:prefecture]
    @category_id = params[:category]
    @price_from = params[:price_from]
    @price_to = params[:price_to]
    @keywords = params[:keywords]
  end

  def call
    @events = Expert.all
    @events = @events.where(category_id: @category_id) if @category_id.present?
    @events = @events.where("skill_title ILIKE :search OR description ILIKE :search ", search: "%" + @keywords + "%")
      .or(@events.where(user: User.where("username ILIKE :search OR first_name ILIKE :search OR last_name ILIKE :search ", search: "%" + @keywords + "%"))) if @keywords.present?
    @events = @events.where("price >= ? ", @price_from) if @price_from.present?
    @events = @events.where("price <= ? ", @price_to) if @price_to.present?
    return @events
  end
end
