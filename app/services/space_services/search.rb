class SpaceServices::Search < ApplicationService
  attr_reader :params

  def initialize(params)
    @starting_at = params[:starting_at]
    @ending_at = params[:ending_at]
    @user_id = params[:user_id]
    @category_id = params[:category]
    @prefecture_id = params[:area]
    @price_from = params[:price_from]
    @price_to = params[:price_to]
    @keywords = params[:keywords]
    @status = params[:status]
    @sort = params[:sort]
  end

  def call
    @spaces = Space.all
    @spaces = @spaces.where(user_id: @user_id) if @user_id.present?
    @spaces = @spaces.where(category_id: @category_id) if @category_id.present?
    @spaces = @spaces.where(prefecture_id: @prefecture_id) if @prefecture_id.present?
    @spaces = @spaces.where("name ILIKE :search OR description ILIKE :search OR address1 ILIKE :search OR address2 ILIKE :search OR address3 ILIKE :search ", search: "%" + @keywords + "%") if @keywords.present?
    @spaces = @spaces.where("price >= ? ", @price_from) if @price_from.present?
    @spaces = @spaces.where("price <= ? ", @price_to) if @price_to.present?
    @spaces = @spaces.status_active if @status.present? && @status.to_i == Space.statuses[:active]
    if (@sort.present?)
      @spaces = @spaces.unscope(:order).order(price: :asc) if @sort == "priceUp"
      @spaces = @spaces.unscope(:order).order(price: :desc) if @sort == "priceDown"
      @spaces = @spaces.unscope(:order).order(created_at: :desc) if @sort == "new"
    end
    return @spaces
  end
end
