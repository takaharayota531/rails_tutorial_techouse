# frozen_string_literal: true

require 'test_helper'

class UsersFollowControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'should redirect following when not logged in' do
    get following_user_path(@user)
    assert_redirected_to login_path
  end
  test 'should redirect followers when not logged in' do
    get followers_user_path(@user)
    assert_redirected_to login_path
  end
end
