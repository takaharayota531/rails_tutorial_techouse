module SessionsHelper
  # sessionで作成されたcookiesはブラウザを閉じた瞬間に消える
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーがいる場合ユーザーを返す
  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  # userがログインしてればtrue,そうでなければfalseを返す
  def logged_in?
    !current_user.nil?
  end

  def log_out 
    reset_session
    @current_user=nil
  end
end
