# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user&.authenticate(params[:session][:password])
      # ログイン前に遷移しようとしていたURLを表示
      forwarding_url = session[:forwarding_url]
      # ここでリダイレクトする

      # 新しいセッションハッシュが使われるようになる
      reset_session
      if params[:session][:remember_me] == '1'
        remember @user
      else
        forget @user
      end
      log_in @user
      # forwarding_urlが存在する場合は事前のurlに飛ぶようにする
      redirect_to forwarding_url || user_path(@user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, status: :see_other
  end
end
