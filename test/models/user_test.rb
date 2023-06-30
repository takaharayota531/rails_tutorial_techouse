# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'example user', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
    # @user.errors.full_messages
  end
  test 'email should be present' do
    @user.email = '  '
    assert_not @user.valid?
  end

  test 'name length should be within 30' do
    @user.name = 'a' * 31
    assert_not @user.valid?
  end
  test 'email length should be within 30' do
    @user.email = 'a' * 310
    assert_not @user.valid?
  end

  test 'email should accept valid adresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test 'email should accept invalid adresses' do
    valid_addresses = %w[userexample.com]
    valid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup

    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email address should be saved as lower case' do
    mixed_email = 'uSer@Example.Com'

    @user.email = mixed_email
    @user.save
    assert_equal @user.reload.email, mixed_email.downcase
  end

  test 'password should be present(nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end
  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '')
  end
end
