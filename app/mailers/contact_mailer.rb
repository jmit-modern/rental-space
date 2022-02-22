class ContactMailer < ApplicationMailer
  def send_contact
    @content = params[:content]
    @admin = User.user_type_admin.first

    mail(to: @admin.email, subject: "A customer sent a contact form.")
  end
end
