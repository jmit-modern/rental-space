class EventReservationSerializer < ActiveModel::Serializer
  attributes :id, :event, :qr_code, :stripe_id, :sub_total, :admin_fee, :owner_tax, :total, :user, :status

  belongs_to :event

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
