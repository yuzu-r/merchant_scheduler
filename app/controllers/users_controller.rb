class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id]) #this is now in before action?
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
    #@user = User.find(params[:id]) #this is now in before action
  end

  def update
    #@user = User.find(params[:id]) #this is now in before action
    if @user.update_attributes(user_params)
      flash[:success] = "User updated"
      #redirect_to users_path if admin this happens
      redirect_to @user
    else
      logger.debug 'edit had invalid data'
      render 'edit'
    end
  end

  def index
  	@users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

    # before filters

    # confirms a logged-in user 
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # confirms a correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
