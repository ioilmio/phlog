class UsersController < ApplicationController
  before_action :user_signed_in?, only: %i[index destroy followers following]

  def index
    @users = User.all
    @opinion = current_user.opinions.build if user_signed_in?
  end

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
    @user = User.find(current_user.id)
    @user.cover.attach(params[:cover]) if @user.cover.attached?
    if @user.update(user_params)

      redirect_to edit_user_path(current_user.id), notice: 'user was successfully updated.'
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
