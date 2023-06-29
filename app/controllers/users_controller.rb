# frozen_string_literal: true

# userを司るコントローラー
class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update]
  before_action :correct_user, only: %i[edit update]


  def index
    @users=User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
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
      reset_session
      log_in @user
      flash[:success] = "welcome to the show page #{@user.name}"
      redirect_to user_path(@user)
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

  private

  def user_params
    # railsはメソッドの最後に評価された式の値が返り値となる
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    # 事前にstore_locationによってログインする前に遷移しようとしていたURLを保管しておく

    store_location

    flash[:danger] = LOG_IN
    redirect_to login_path, status: :see_other
  end

  def correct_user
    @user = User.find(params[:id])
    (redirect_to root_path, status: :see_other) unless current_user?(@user)
  end
end
