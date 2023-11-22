class UserAccountController < ApplicationController
  before_filter :set_user_account, only: [:show]

  def index
    with_org do
      rest_response @user_accounts = UserAccount.includes(:user).all, :user
    end
  end

  def show
    rest_response @user_account, :user
  end

  def create
    with_org { rest_response @user_account = UserAccount.create!(user_account_params) }
  end

  private

  def set_user_account
    with_org do
      id = params[:id]
      return @user_account if (@user_account = UserAccount.includes(:user).find_by(id: id))
      raise "Not found UserAccount, id: #{id}"
    end
  end

  def user_account_params
    params.require(:user_account).permit(:user_id)
  end
end
