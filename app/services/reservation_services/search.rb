class ReservationServices::Search < ApplicationService
  attr_reader :params

  def initialize(params)
    @user_id = params[:user_id]
    @space_id = params[:space_id]
    @plan_id = params[:plan_id]
    @category_id = params[:category_id]
    @category_id = params[:reserve_from]
    @category_id = params[:reserve_to]
  end

  def call
    @reservations = Reservation.all

    @reservations = @reservations.where(user_id: @user_id) if @user_id.present?
    @reservations = @reservations.where(space_id: @space_id) if @space_id.present?
    @reservations = @reservations.find_by(plan_id: @plan_id) if @plan_id.present?
    @reservations = @reservations.find_by(category_id: @category_id) if @category_id.present?
    @reservations = @reservations.where("reserve_from > ?", @reserve_from) if @reserve_from.present?
    @reservations = @reservations.where("reserve_from < ?", @reserve_to) if @reserve_to.present?
    @reservations
  end
end
