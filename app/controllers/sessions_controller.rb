class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      logger.debug "about to log in user"
      log_in user
      logger.debug "login worked, about to redirect"
      #after_login_dumass
      redirect_to help_path
    else
      logger.debug "login did not work, rendering session new"
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
