class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user, :space, :plan, :category, :people, :children, :description, :reserve_from, :reserve_to, :sub_total, :admin_fee, :owner_tax, :total, :approved, :status, :payment_exec_time

  belongs_to :space
  belongs_to :category

  def plan
    object.space_plan
  end

  def user
    {
      full_name: object.user.full_name,
      email: object.user.email,
      phone: object.user.phone,
    }
  end
end
