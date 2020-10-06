class UsersController < ApplicationController
  before_action :user_signed_in?, only: %i[index destroy followers following]

  def show
    @user = User.find(params[:id])
    @opinions = Opinion.all
    @user_opinion = @user.opinions.most_recent
    @opinion = @user.opinions.build
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)

      sign_in_and_redirect @user, notice: 'user was successfully updated.'
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render '_following'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render '_follower'
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation, :cover, :photo)
  end
end
