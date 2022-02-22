class ExpertReservationMailer < ApplicationMailer
  def user_email_confirm
    @expert_reservation = params[:expert_reservation]
    @user = @expert_reservation.user

    mail(to: @user.email, subject: "You have invited the expert.")
  end

  def expert_email_confirm
    @expert_reservation = params[:expert_reservation]
    @expert_user = @expert_reservation.expert.user

    mail(to: @expert_user.email, subject: "You are invited by a customer")
  end

  def expert_email_payment_complete
    @expert_reservation = params[:expert_reservation]
    @expert_user = @expert_reservation.expert.user

    mail(to: @expert_user.email, subject: "Payment has been completed from the customer")
  end

  def user_email_payment_complete
    @expert_reservation = params[:expert_reservation]
    @user = @expert_reservation.user

    mail(to: @user.email, subject: "Your Payment has been completed")
  end

  def user_email_reservation_canceled
    @expert_reservation = params[:expert_reservation]
    @user = @expert_reservation.user

    mail(to: @user.email, subject: "Your reservation has been canceled.")
  end
end
