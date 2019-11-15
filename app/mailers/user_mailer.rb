class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot.subject
  #
  def forgot(user)
    @greeting = "Hi"
    @user = user
    @reset_password_token = user.reset_password_token
    mail to: @user.email, :subject => "Forgot Password"
  end
end
