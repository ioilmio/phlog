class OpinionsController < ApplicationController
  before_action :authenticate_user!
  before_action :signed_in_only, only: %i[new create edit destroy]
  before_action :set_opinion, only: %i[show edit update destroy]

  def index
    @opinions = Opinion.all.most_recent
    return unless user_signed_in?

    @opinion = current_user.opinions.build
    @feed = current_user.feed.most_recent
  end

  def show
    @opinion = Opinion.find(params[:id])
    @opinions = current_user.opinions.most_recent
    @user = @opinion.user
  end

  def new
    @opinion = Opinion.new
  end

  def edit; end

  def create
    @opinion = current_user.opinions.build(opinion_params)
    @opinion.image.attach(params[:opinion][:image]) if params[:opinion][:image].present?
    if @opinion.save
      redirect_to @opinion, notice: 'Opinion was successfully created.'
    else
      render :new
    end
  end

  def update
    @opinion.image.attach(params[:opinion][:image]) if params[:opinion][:image].present?
    if @opinion.update(opinion_params)
      redirect_to @opinion, notice: 'Opinion was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @opinion.destroy
    redirect_to opinions_url, notice: 'Opinion was successfully destroyed.'
  end

  private

  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  def signed_in_only
    redirect_to new_user_session_path unless current_user
  end

  def opinion_params
    params.require(:opinion).permit(:content, :user_id, :image)
  end
end
