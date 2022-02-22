class ReservationServices::Checkout < ApplicationService
  attr_reader :plan, :reserve_from, :reserve_to

  def initialize(plan, reserve_from, reserve_to)
    @plan = plan
    @reserve_from = reserve_from
    @reserve_to = reserve_to
  end

  def call
    @sub_total = (@plan.price * ReservationServices::Worker.time_diff(@reserve_from, @reserve_to)).round
    @admin_fee = admin_fee(@sub_total)
    @owner_tax = owner_tax(@sub_total)
    @total = @sub_total + @admin_fee + @owner_tax

    { :sub_total => @sub_total, :admin_fee => @admin_fee, :owner_tax => @owner_tax, :total => @total }
  end

  private

  def admin_fee(price)
    (price * 0.05).round
  end

  def owner_tax(price)
    (price * 0.1).round
  end
end
