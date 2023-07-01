class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])

    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = ACCOUNT_ACTIVATED
      redirect_to user_path(user)
    else
      flash[:danger] = INVALID_ACTIVATION_LINK
      redirect_to root_path
    end
  end
end
