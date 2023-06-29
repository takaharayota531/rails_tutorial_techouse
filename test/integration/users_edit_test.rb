require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @edit_path = 'users/edit'
  end
  test 'unsuccessful edit' do
    log_in_as_in_integration(@user)
    get edit_user_path(@user)
    assert_template @edit_path

    patch user_path(@user),
          params: {
            user: {
              name: '',
              email: 'foo@invalid',
              password: 'foo',
              password_confirmation: 'bar'
            }
          }

    assert_template @edit_path
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as_in_integration(@user)

    assert_redirected_to edit_user_path(@user)
    patch user_path(@user), params: {
      user: {
        name: '@user.name',
        email: @user.email,
        password: '',
        password_confirmation: ''
      }
    }
    assert_not flash.empty?
    assert_equal SUCCESSFULLY_UPDATED, flash[:success]

    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal '@user.name', @user.name
    # assert_equal @user.email,@user.email
  end
end
