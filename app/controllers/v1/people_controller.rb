module V1
  class PeopleController < ApplicationController
  	before_action :set_person, only: [:show, :update, :destroy]
  	skip_before_action :authorize_request, only: [:index, :show]

  	# GET /people
    def index
      @people = Person.all
      render json: @people, status: :ok
    end

    # POST /people
    def create
      @person = Person.create!(permitted_params)
      render json: @person, status: :ok
    end

    # GET /people/:id
    def show
      render json: @person, status: :ok
    end

    # PUT /people/:id
    def update
      @person.update(permitted_params)
      head :no_content
    end

    # DELETE /people/:id
    def destroy
      @person.destroy
      head :no_content
    end

    private

    def set_person
      @person = Person.find(params[:id])
    end

    def permitted_params
      params.permit(:last_name, :first_name, :aliases)
    end
  end
end
