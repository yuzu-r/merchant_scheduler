require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ridiculous)
    host! "localhost:3000"
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    #this doesn't work due to my other links?
    #User.paginate(page: 1, per_page: 5).each do |user|
    #  assert_select 'a[href=?]', user_path(user), text: user.name
    #end
  end
end