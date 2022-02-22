class Api::V1::Front::ContactController < ApplicationController
  def send_form
    ContactServices::Send.call(contact_params)
    return render json: { message: "Email sent" }, status: :ok
  end

  private

  # Only allow a list of trusted parameters through.
  def contact_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :subject,
      :message,
    )
  end
end
