class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create	 
    @user = User.new(user_params)
	  if @user.save
	  	 flash[:success] = "User successfully created."
	    redirect_to users_path
	  else
	    render 'new'
	  end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User updated"
      redirect_to @user
    else
      logger.debug 'edit had invalid data'
      render 'edit'
    end
  end

  def index
  	@users = User.all
  end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
