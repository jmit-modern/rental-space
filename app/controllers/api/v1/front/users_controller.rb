class Api::V1::Front::UsersController < ApplicationController
  before_action :authorize_request, except: %i[create show index user_types mail_test confirm_user]

  before_action :find_user, except: %i[create index show user_types mail_test]

  # GET /api/v1/users or /api/v1/users.json
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /api/v1/users/1 or /api/v1/users/1.json
  def show
    begin
      @user = User.find(params[:id])
    rescue => e
      logger.info e
      return render json: { message: "user id not found" }, status: :not_found
    end
    render json: @user
  end

  # POST /api/v1/users or /api/v1/users.json
  def create
    @user = UserServices::CreateUser.call(user_params)
    if @user.save
      # Send register confirmation email to user
      UserMailer.with(:user => @user).confirm_email.deliver_now
      render json: { message: "User Created Successfully" }, status: :created
    else
      render json: { errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1 or /api/v1/users/1.json
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: { message: "User Updated Successfully" }, status: :ok
    end
  end

  # DELETE /api/v1/users/1 or /api/v1/users/1.json
  def destroy
    @user.destroy
  end

  def update_email
    unless @user.update(email: params[:email])
      render json: { errors: @user.errors },
             status: :unprocessable_entity
    else
      render json: { message: "User emali updated successfully" }, status: :ok
    end
  end

  def confirm_user
    if params[:token].present? && @user.confirm_token == params[:token]
      @user.status_active!
    end
  end

  def update_password
    # Check the current password
    if @user&.authenticate(params[:current_password])

      # update the new password
      if @user.update(plain_password: params[:new_password])
        render json: { message: "User password updated successfully" }, status: :ok
      else
        render json: { errors: @user.errors },
               status: :unprocessable_entity
      end
    else
      @user.errors[:current_password] << "現在のパスワードを正確に入力してください。"
      render json: { errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  def user_types
    render json: User.user_types, status: :ok
  end

  private

  # User callbacks to share common setup or constraints between actions.
  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User not found" }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:username, :email, :plain_password, :user_type, :first_name, :last_name, :description, :phone, :address, :photo)
  end
end
