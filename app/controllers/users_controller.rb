# frozen_string_literal: true

# userを司るコントローラー
class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy following followers]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: %i[destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_path and return unless @user.activated?
  end

  def new
    @constant_create_account = CREATE_ACCOUNT
    @constant_sign_up = SIGN_UP
    @user = User.new
  end

  def create
    # やっと理解したこれjsonで受け取ってるだけ
    @user = User.new(user_params)

    # return if @user.save
    if @user.save

      @user.send_activation_email
      flash[:info] = ACTIVATE_MESSAGE
      redirect_to root_path
      # reset_session
      # log_in @user
      # flash[:success] = "welcome to the show page #{@user.name}"
      # redirect_to user_path(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = SUCCESSFULLY_UPDATED
      redirect_to user_path(@user)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = USER_DELETED
    redirect_to users_path, status: :see_other
  end

  def following
    @title = FOLLOWING
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render SHOW_FOLLOW, status: :unprocessable_entity
  end

  def followers
    @title = FOLLOWERS
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render SHOW_FOLLOW, status: :unprocessable_entity
  end

  private

  def user_params
    # railsはメソッドの最後に評価された式の値が返り値となる
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    (redirect_to root_path, status: :see_other) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    (redirect_to root_path, status: :see_other) unless current_user.admin?
  end
end
