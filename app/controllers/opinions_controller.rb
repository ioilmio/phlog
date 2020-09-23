class OpinionsController < ApplicationController
  before_action :set_opinion, only: %i[show edit update destroy]

  def index
    @opinions = Opinion.all
  end

  def show; end

  def new
    @opinion = Opinion.new
  end

  def edit; end

  def create
    @opinion = current_user.opinions.new(opinion_params)

    respond_to do |format|
      if @opinion.save
        format.html { redirect_to @opinion, notice: 'Opinion was successfully created.' }
        format.json { render :show, status: :created, location: @opinion }
      else
        format.html { render :new }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to @opinion, notice: 'Opinion was successfully updated.' }
        format.json { render :show, status: :ok, location: @opinion }
      else
        format.html { render :edit }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to opinions_url, notice: 'Opinion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  def opinion_params
    params.require(:opinion).permit(:content, :user_id)
  end
end
