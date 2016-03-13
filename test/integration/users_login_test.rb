require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:ridiculous	)
		host! "localhost:3000" #if you do not do this, it will go to example.com/help
    ActionMailer::Base.deliveries.clear
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

  test "login with valid information then logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to help_path
    follow_redirect! 
		assert_template 'static_pages/help'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

  test "valid signup information with account activation" do
    get login_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name:  "Example User",
                               email: "user@example.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong@me.com')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end
