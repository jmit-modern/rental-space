class ExpertReservationSerializer < ActiveModel::Serializer
  attributes :id, :user, :expert_id, :expert, :category, :people, :children, :description, :reserve_from, :reserve_to, :sub_total, :admin_fee, :owner_tax, :total, :approved, :status, :payment_exec_time, :location

  belongs_to :category
  belongs_to :expert

  def user
    {
      id: object.user.id,
      email: object.user.email,
      username: object.user.username,
      full_name: object.user.full_name,
      email: object.user.email,
      phone: object.user.phone,
    }
  end
end
