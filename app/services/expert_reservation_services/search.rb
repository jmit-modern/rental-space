class ExpertReservationServices::Search < ApplicationService
  attr_reader :params

  def initialize(params)
    @user_id = params[:user_id]
    @expert_id = params[:expert_id]
    @category_id = params[:category_id]
    @category_id = params[:reserve_from]
    @category_id = params[:reserve_to]
  end

  def call
    @reservations = ExpertReservation.all

    @reservations = @reservations.where(user_id: @user_id) if @user_id.present?
    @reservations = @reservations.where(expert_id: @expert_id) if @space_id.present?
    @reservations = @reservations.find_by(category_id: @category_id) if @category_id.present?
    @reservations = @reservations.where("reserve_from > ?", @reserve_from) if @reserve_from.present?
    @reservations = @reservations.where("reserve_from < ?", @reserve_to) if @reserve_to.present?
    @reservations
  end
end
