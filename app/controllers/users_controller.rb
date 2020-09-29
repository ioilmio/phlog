class UsersController < ApplicationController
  before_action :user_signed_in?, only: %i[index edit update destroy followers following]

  def index
    @users = User.all
    @opinion = current_user.opinions.build if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
    @opinions = Opinion.all
    @my_opinion = @user.opinions.most_recent
    @opinion = @user.opinions.build
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'user was successfully updated.'
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers

    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation)
  end
end
