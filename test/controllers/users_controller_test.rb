# frozen_string_literal: true

require 'test_helper'
class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_equal LOG_IN, flash[:danger]
    assert_redirected_to login_path
  end

  test 'should redirect update when not logged in ' do
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }
    assert_equal LOG_IN, flash[:danger]
    assert_redirected_to login_path
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as_in_integration(@other_user)
    get edit_user_path(@user)
    # assert_equal LOG_IN, flash[:danger]
    assert flash.empty?

    assert_redirected_to root_path
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as_in_integration(@other_user)
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }
    assert flash.empty?
    #  assert_equal LOG_IN,flash[:danger]
    assert_redirected_to root_path
  end

  test "should redirect index when not logged in" do 

    get users_path 
    assert_redirected_to login_path
  end

  test "should not allow the admin attribute to be edited via web" do 
    log_in_as_in_integration(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user),params:{
      user:{
        password:'password',
        password_confirmation: 'password',
        admin: true
      }
    }
    assert_not @other_user.reload.admin?
  end

end
