module V1
  class MoviesPeopleController < ApplicationController
  	before_action :set_movie_person, only: [:show, :update, :destroy]
  	skip_before_action :authorize_request, only: [:index, :show]

  	# GET /movies_people
    def index
      @movies_people = MoviesPerson.all
      render json: @movies_people, status: :ok
    end

    # POST /movies_people
    def create
      @movie_person = MoviesPerson.create!(permitted_params)
      render json: @movie_person, status: :ok
    end

    # GET /movies_people/:id
    def show
      render json: @movie_person, status: :ok
    end

    # PUT /movies_people/:id
    def update
      @movie_person.update(permitted_params)
      render json: @movie_person, status: :ok
    end

    # DELETE /movies_people/:id
    def destroy
      @movie_person.destroy
      render json: { message: 'The movie person has been destroyed' }, status: :ok
    end

    private

    def set_movie_person
      @movie_person = MoviesPerson.find(params[:id])
    end

    def permitted_params
      params.permit(:movie_id, :person_id, :type)
    end
  end
end
