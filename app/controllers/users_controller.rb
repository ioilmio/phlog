class UsersController < ApplicationController
  def index; end

  def show; end

  def following
    @user = User.find(params[:id])
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
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
