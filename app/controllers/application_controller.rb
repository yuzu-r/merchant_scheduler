class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def after_login_dumass
  	#need a redirect here, a render doesnt need a method
  	#redirect_to help_path
  end

end
