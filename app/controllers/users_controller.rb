# frozen_string_literal: true

# userを司るコントローラー
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # やっと理解したこれjsonで受け取ってるだけ
    @user = User.new(user_params)

    # return if @user.save
    if @user.save
      flash[:success] = "welcome to the show page #{@user.name}"
      redirect_to user_path(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    # railsはメソッドの最後に評価された式の値が返り値となる
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
