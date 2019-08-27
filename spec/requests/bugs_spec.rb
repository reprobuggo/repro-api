require 'rails_helper'

RSpec.describe 'Bugs API', type: :request do
  # initialize test data
  let!(:bugs) { create_list(:bug, 10) }
  let(:bug_id) { bugs.first.id }

  # Test suite for GET /bugs
  describe 'GET /bugs' do
    # make HTTP get request before each example
    before { get '/bugs' }

    it 'returns bugs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /bugs/:id
  describe 'GET /bugs/:id' do
    before { get "/bugs/#{bug_id}" }

    context 'when the record exists' do
      it 'returns the bug' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bug_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:bug_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bug/)
      end
    end
  end

  # Test suite for POST /bugs
  describe 'POST /bugs' do
    # valid payload
    let(:valid_attributes) { { title: 'My computer is on fire', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/bugs', params: valid_attributes }

      it 'creates a bug' do
        expect(json['title']).to eq('My computer is on fire')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/bugs', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /bugs/:id
  describe 'PUT /bugs/:id' do
    let(:valid_attributes) { { title: 'My computer broke in half' } }

    context 'when the record exists' do
      before { put "/bugs/#{bug_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /bugs/:id
  describe 'DELETE /bugs/:id' do
    before { delete "/bugs/#{bug_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
