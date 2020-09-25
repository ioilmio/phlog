class UsersController < ApplicationController
  def index
    @users = User.all
    @opinion = current_user.opinions.build if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
    @opinions = Opinion.all
    @opinion = @user.opinions.most_recent
  end

  def edit
    @user = User.find(params[:id])
  end

  def following
    @user = current_user
    render 'show_follow'
  end

  def followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation)
  end
end
