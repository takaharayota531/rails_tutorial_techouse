# frozen_string_literal: true

require 'test_helper'

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
end

class InvalidPasswordTest < UsersLogin
  test 'login path' do
    get login_path
    assert_template 'sessions/new'
  end

  test 'login with valid email/invalid password' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: 'passworwwd' } }

    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert_not is_logged_in?
  end
end


class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: {
      session: {
        email: @user.email,
        password: 'password'
      }
    }
  end
end


class ValidLoginTest < ValidLogin
  

  test "valid login"  do 
    assert is_logged_in?
    assert_redirected_to user_path(@user)
  end


end

class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout
  test 'successful logout' do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end
  test 'redirect after logout' do
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path,      count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test 'should still work after logout in second window' do
    delete logout_path
    assert_redirected_to root_url
  end
end

class RememberingTest < UsersLogin
  test 'login with remembering' do
    log_in_as_in_integration(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?
  end
  test 'login without remembering' do
    # Cookie を保存してログイン
    log_in_as_in_integration(@user, remember_me: '1')
    # Cookie が削除されていることを検証してからログイン
    log_in_as_in_integration(@user, remember_me: '0')
    assert cookies[:remember_token].blank?
  end
end
