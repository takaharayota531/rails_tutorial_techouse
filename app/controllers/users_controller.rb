# frozen_string_literal: true

# userを司るコントローラー
class UsersController < ApplicationController
 

  def show
    @user = User.find(params[:id])
  end

  def new 
    @user=User.new
  end
end
