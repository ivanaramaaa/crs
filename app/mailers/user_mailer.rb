class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "CRS Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
   def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

  def receipt(user, receipt, registration)
   @user = user
   @receipt = receipt
   @conf_reg = registration
   mail to: user.email, subject: "CRS Conference Registration Receipt"
  end
end
