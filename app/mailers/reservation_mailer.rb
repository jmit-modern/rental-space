class ReservationMailer < ApplicationMailer
  def user_email_confirm
    @reservation = params[:reservation]
    @user = @reservation.user

    mail(to: @user.email, subject: "Your space reservation is now in progress")
  end

  def expert_email_confirm
    @reservation = params[:reservation]
    @owner = @reservation.space.user

    mail(to: @owner.email, subject: "A customer wants to reserve your space")
  end

  def user_email_approved
    @reservation = params[:reservation]
    @user = @reservation.user

    mail(to: @user.email, subject: "Your space reservation has been approved")
  end

  def expert_email_payment_complete
    @reservation = params[:reservation]
    @owner = @reservation.space.user

    mail(to: @owner.email, subject: "Payment has been completed from the customer")
  end

  def user_email_payment_complete
    @reservation = params[:reservation]
    @user = @reservation.user

    mail(to: @user.email, subject: "Your Payment has been completed.")
  end

  def user_email_reservation_canceled
    @reservation = params[:reservation]
    @user = @reservation.user

    mail(to: @user.email, subject: "Your reservation has been canceled.")
  end
end
