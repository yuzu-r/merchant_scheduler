require 'test_helper'

class UsersCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ridiculous)
    host! "localhost:3000" #if you do not do this, it will go to example.com/help
  end
  
  test "check for invalid information" do
  	get new_user_path
  	assert_no_difference 'User.count' do
  		post users_path, user: {name: "",
  														email: "invaliduser@example.com",
  														password: "nah",
  														password_confirmation: "meh" }
  	end
  	assert_template 'users/new'
  end

  test "create user with valid information" do
    log_in_as(@user)
  	get new_user_path
  	assert_difference 'User.count', 1 do
  	post_via_redirect users_path, user: {name: "Example User", 
  																			email: "example.user@example.com",
  																			password: "password",
  																			password_confirmation: "password" }
		end
		assert_template 'users/index'
		assert_not flash.empty?
	end
end
