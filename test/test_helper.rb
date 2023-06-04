# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    def is_logged_in?
      !session[:user_id].nil?
    end

    # テストユーザーとしてログインする
    def log_in_as(user)
      session[:user_id] = user.id
    end
  end
end

# ここの記法があっているかわからん
module ActionDispatch
  class IntegrationTest
    # テストユーザーとしてログインする
    # キーのデフォルトも定めている
    def log_in_as_in_integration(user, password: 'password', remember_me: '1')
      # integration testではsessionが使えない
      post login_path, params: {
        session: {
          email: user.email,
          password:,
          remember_me:
        }
      }
    end
  end
end
