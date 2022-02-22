class UserServices::CreateUser < ApplicationService
  attr_reader :user_params

  def initialize(user_params)
    @params = user_params
  end

  def call
    @existing_user = User.where({ email: @params[:email], status: 0 })
    User.destroy(@existing_user.ids[0]) if @existing_user.present?
    return User.new(@params.merge({ confirm_token: SecureRandom.uuid }))
  end
end
