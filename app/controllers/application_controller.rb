class ApplicationController < ActionController::API
  attr_reader :current_user

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      user = User.find(@decoded[:user_id])
      if user
        @current_user ||= user
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def admin_only
    unless @current_user and @current_user.user_type_admin?
      render json: { errors: "Admin permission required" }, status: :unauthorized
    end
  end

  def is_admin?
    @current_user.user_type_admin?
  end

  def not_found
    render json: { error: "not_found" }
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      per_page: collection.per_page,
      total_pages: collection.total_pages,
      total: collection.count,
    }
  end
end
