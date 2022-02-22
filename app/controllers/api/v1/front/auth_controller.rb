class Api::V1::Front::AuthController < ApplicationController
  before_action :authorize_request, except: %i[login reset_password update_password]

  def login
    @user = User.find_by_email(params[:email])
    if @user.status_active? && @user&.authenticate(params[:plain_password])
      token = JsonWebToken.encode(user_id: @user.id)

      time = Time.now + 24.hours.to_i

      # Save user last login
      @user.update(last_login: Time.now)

      render json: { jwt: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end

  def show
    user = User.find(@current_user.id)
    render json: user, status: :ok
  end

  def logout
    render json: { message: "Log out Successfully" }, status: :ok
  end

  def reset_password
    @user = User.where(email: params[:email]).first
    if @user.present?
      # Send user password reset email
      @user.update({ confirm_token: SecureRandom.uuid })
      UserMailer.with(:user => @user).password_reset_email.deliver_now
      render json: { message: "Password reset email sent!" }, status: :ok
    else
      render json: { errors: { email: "ユーザが存在しません。 新しいアカウントを登録してください。" } }, status: :not_found
    end
  end

  def update_password
    begin
      @user = User.find(params[:user_id])
      # Check the current password
      if @user.confirm_token.present? && @user.confirm_token == params[:token]

        # update the new password
        if @user.update(plain_password: params[:new_password])
          render json: { message: "User password updated successfully" }, status: :ok
        else
          render json: { errors: @user.errors },
                 status: :unprocessable_entity
        end
      else
        @user.errors[:token] << "無効なトークンです。"
        render json: { errors: @user.errors },
               status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "User not found" }, status: :not_found
    end
  end

  private

  def login_params
    params.permit(:email, :plain_password)
  end
end
