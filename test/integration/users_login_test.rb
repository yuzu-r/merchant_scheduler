require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:ridiculous	)
		host! "localhost:3000" #if you do not do this, it will go to example.com/help
	end

	test "login with invalid information" do
		get login_path
		assert_template 'sessions/new'
		post login_path, session: {email: @user.email, password: 'incorrect' }
		assert_template 'sessions/new'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end
	
  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to help_path
    follow_redirect! 
		assert_template 'static_pages/help'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert is_logged_in? 
  end

end
