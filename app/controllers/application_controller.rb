# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # どこからでもsessionコントローラーのメソッドが呼び出せるようにした
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    # 事前にstore_locationによってログインする前に遷移しようとしていたURLを保管しておく

    store_location

    flash[:danger] = LOG_IN
    redirect_to login_path, status: :see_other
  end
end
