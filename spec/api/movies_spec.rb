require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  let!(:movies) { create_list(:movie, 10) }
  let(:movie_id) { movies.first.id }
  let!(:user) { User.find_by(name: 'test', email: 'test@test.com') || User.create!(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test') }

  # Test suite for GET /v1/movies
  describe 'GET /v1/movies' do
    before { get '/v1/movies' }

    it 'returns movies' do
      json_response = JSON.parse(response.body)
      expect(json_response).not_to be_empty
      expect(json_response.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/movies/:id
  describe 'GET /v1/movies/:id' do
    before { get "/v1/movies/#{movie_id}" }

    context 'when the record exists' do
      it 'returns the movie' do
        json_response = JSON.parse(response.body)

        expect(json_response).not_to be_empty
        expect(json_response['id']).to eq(movie_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:movie_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Movie with 'id'=100/)
      end
    end
  end

  # Test suite for POST /v1/movies
  describe 'POST /v1/movies' do
    context 'when the request is valid' do
      let(:valid_attributes) { { title: 'Fight Club', release_year: 1999 } }

      it 'creates a todo returns status code 201' do
        post '/v1/movies', params: valid_attributes, headers: { 'Authorization' => true }
        json_response = JSON.parse(response.body)
        expect(json_response['title']).to eq('Fight Club')
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: 'Fight Club' } }
      it 'returns status code 422' do
        post '/v1/movies', params: invalid_attributes, headers: { 'Authorization' => true }
        expect(response).to have_http_status(422)
        expect(response.body).to match(/Validation failed: Release year can't be blank/)
      end
    end
  end

  # Test suite for PUT /v1/movies/:id
  describe 'PUT /v1/movies/:id' do
    let(:valid_attributes) { { title: 'Matrix' } }

    context 'when the record exists' do
      it 'updates the record and returns status code 200' do
        put "/v1/movies/#{movie_id}", params: valid_attributes, headers: { 'Authorization' => true }
        json_response = JSON.parse(response.body)
        expect(json_response['title']).to eq('Matrix')
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /v1/movies/:id
  describe 'DELETE /v1/movies/:id' do
    it 'returns status code 200' do
      delete "/v1/movies/#{movie_id}", headers: { 'Authorization' => true }
      expect(response).to have_http_status(200)
      expect(Movie.count).to eq(9)
    end
  end
end