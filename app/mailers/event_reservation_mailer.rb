class EventReservationMailer < ApplicationMailer
  def user_email_confirm
    @event_reservation = params[:event_reservation]
    @user = @event_reservation.user

    mail(to: @user.email, subject: "You purchased the event ticket.")
  end

  def event_owner_email_confirm
    @event_reservation = params[:event_reservation]
    @event_owner = @event_reservation.event.user

    mail(to: @event_owner.email, subject: "A customer purchased a event ticket.")
  end
end
