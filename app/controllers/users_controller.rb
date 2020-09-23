class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    set_user
  end

  def following
    set_user
    render 'show_follow'
  end

  def followers
    set_user
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation)
  end
end
