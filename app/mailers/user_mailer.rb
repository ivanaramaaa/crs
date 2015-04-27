class UserMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
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

  def last_digits(number)    
    number.length <= 4 ? number : number.slice(-4..-1) 
  end

   def mask(number)
     "XXXX-XXXX-XXXX-#{last_digits(number)}"
   end

  def receipt(user, receipt, registration, event_registration)
   @user = user
   @receipt = receipt
   @conf_reg = registration
   @event_regs = event_registration
   @conf = Conference.find_by(id: @conf_reg.conference_id)
   @paper_id = @conf_reg.paper_id
   @paper = nil
   if !@paper_id.nil?
     @paper = Paper.find_by(id: @paper_id)
   end
   @card = CreditCard.find_by(id: 4)
   @card_num = mask(@card.number)
   @total = number_to_currency(@receipt.total)
   mail to: user.email, subject: "CRS Conference Registration Receipt"
  end
end
