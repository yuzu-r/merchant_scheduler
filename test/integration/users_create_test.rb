require 'test_helper'

class UsersCreateTest < ActionDispatch::IntegrationTest
  
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
  	get new_user_path
  	assert_difference 'User.count', 1 do
  		post_via_redirect users_path, user: {name: "Example User", 
  																				email: "example.user@example.com",
  																				password: "password",
  																				password_confirmation: "password" }
		end
		assert_template 'users/show'
		assert_not flash.empty?
	end
end
