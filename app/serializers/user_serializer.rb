class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :username, :email, :user_type, :card_number, :photo, :status, :last_login, :description, :phone, :address, :spaces, :events, :expert
end
