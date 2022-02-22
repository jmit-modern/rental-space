class UserMailer < ApplicationMailer
  def confirm_email
    @token = params[:user].confirm_token
    @user_id = params[:user].id

    mail(to: params[:user].email, subject: "Please confirm your email")
  end

  def password_reset_email
    @token = params[:user].confirm_token
    @user_id = params[:user].id

    mail(to: params[:user].email, subject: "Reset your password")
  end
end
