class Api::V1::Admin::UsersController < ApplicationController
  before_action :authorize_request
  before_action :admin_only
  before_action :find_user, except: %i[create index show]

  # GET /api/v1/users or /api/v1/users.json
  def index
    @users = User.all
    @users = @users.paginate(page: params[:page], per_page: 25)
    render json: @users, meta: pagination_dict(@users), status: :ok
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
