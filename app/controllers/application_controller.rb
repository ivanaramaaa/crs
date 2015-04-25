class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def admin_access
  	unless current_user.try(:admin?)
  		flash[:danger] = "You must be an administrator to access that section."
  		redirect_to(root_url)
  	end
  end

  def last_digits(number)    
    number.length <= 4 ? number : number.slice(-4..-1) 
  end

   def mask(number)
     "XXXX-XXXX-XXXX-#{last_digits(number)}"
   end

   rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
   end
end