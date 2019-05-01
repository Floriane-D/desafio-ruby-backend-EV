class ResultsController < ApplicationController
  before_action :set_result, only: :show
  before_action :set_competition, only: :create
  before_action :set_athlete, only: :create

  def show
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      render :show, status: :created, location: @result
    else
      render_error
    end
  end

  private

  def set_result
    @result = Result.find(params[:id])
  end

  def set_competition
    unless params[:competition_id].present?
      competition = Competition.new(name: params[:competition])
      competition.unit = params[:unit] if params[:unit].present?
      params[:competition_id] = competition.id
    end
  end

  def set_athlete
    unless params[:athlete_id].present?
      athlete = Athlete.new(name: params[:athlete])
      params[:athlete_id] = athlete.id
    end
  end

  def result_params
    params.permit(:competition_id, :athlete_id, :value)
  end

  def render_error
    render json: { errors: @result.errors },
      status: :unprocessable_entity
  end
end
