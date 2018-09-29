class MoviesController < ApplicationController
	before_action :set_movie, only: [:show, :update, :destroy]
	skip_before_action :authorize_request, only: [:index, :show]

	# GET /movies
  def index
    @movies = Movie.all
    render json: @movies, status: :ok
  end

  # POST /movies
  def create
    @movie = Movie.create!(permitted_params)
    render json: @movie, status: :ok
  end

  # GET /movies/:id
  def show
    render json: @movie, status: :ok
  end

  # PUT /movies/:id
  def update
    @movie.update(permitted_params)
    head :no_content
  end

  # DELETE /movies/:id
  def destroy
    @movie.destroy
    head :no_content
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def permitted_params
    params.permit(:title, :release_year)
  end

end
