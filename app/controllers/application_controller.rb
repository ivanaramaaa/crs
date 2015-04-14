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
end
