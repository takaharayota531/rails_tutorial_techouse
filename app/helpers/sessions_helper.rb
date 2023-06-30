# frozen_string_literal: true

module SessionsHelper
  # sessionで作成されたcookiesはブラウザを閉じた瞬間に消える
  def log_in(user)
    session[:user_id] = user.id
    # セッションリプレイ攻撃から保護する
    session[:session_token] = user.session_token
  end

  # 現在ログイン中のユーザーがいる場合ユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      @current_user = user if user && session[:session_token] == user.session_token
    elsif (user_id = cookies.encrypted[:user_id])
      # raise
      user = User.find_by(id: user_id)
      # raise
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  # 永続化セッションのためにユーザーを記憶する
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # userがログインしてればtrue,そうでなければfalseを返す
  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  # アクセスしようとしたURLを保存する
  def store_location
    # original_urlが遷移しようとしていたURL
    session[:forwarding_url] = request.original_url if request.get?
  end
end
