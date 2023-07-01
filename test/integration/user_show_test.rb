require 'test_helper'
class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @inactive_user = users(:inactive)
    @active_user = users(:archer)
  end

  test 'should redirect when user not activated' do
    get user_path(@inactive_user)
    assert_redirected_to root_path
  end
  test 'should redirect when user  activated' do
    get user_path(@active_user)
    assert_template 'users/show'
  end
end
