# frozen_string_literal: true

class UserController < ApplicationController
  before_filter :set_user, only: [:show]

  def index
    with_org { rest_response @users = User.all }
  end

  def show
    rest_response @user
  end

  def create
    with_org { rest_response @user if (@user = User.create! user_params) }
  end

  private

  def set_user
    with_org do
      username = params[:id]
      return @user if (@user = User.find_by_username username)
      rest_error "Not found User, username: #{username}"
    end
  end

  def user_params
    params.require(:user).permit(:username, :name, :email)
  end
end
