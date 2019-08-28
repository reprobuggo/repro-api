require 'rails_helper'

RSpec.describe 'Steps API' do
  # Initialize the test data
  let!(:bug) { create(:bug) }
  let!(:steps) { create_list(:step, 20, bug_id: bug.id) }
  let(:bug_id) { bug.id }
  let(:id) { steps.first.id }

  # Test suite for GET /bugs/:bug_id/steps
  describe 'GET /bugs/:bug_id/steps' do
    before { get "/bugs/#{bug_id}/steps" }

    context 'when bug exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all bug steps' do
        expect(json.size).to eq(20)
      end
    end

    context 'when bug does not exist' do
      let(:bug_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bug/)
      end
    end
  end

  # Test suite for GET /bugs/:bug_id/steps/:id
  describe 'GET /bugs/:bug_id/steps/:id' do
    before { get "/bugs/#{bug_id}/steps/#{id}" }

    context 'when bug step exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the step' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when bug step does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Step/)
      end
    end
  end

  # Test suite for PUT /bugs/:bug_id/steps
  describe 'POST /bugs/:bug_id/steps' do
    let(:valid_attributes) { { name: 'Pour water into the keyboard', done: false } }

    context 'when request attributes are valid' do
      before { post "/bugs/#{bug_id}/steps", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/bugs/#{bug_id}/steps", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /bugs/:bug_id/steps/:id
  describe 'PUT /bugs/:bug_id/steps/:id' do
    let(:valid_attributes) { { name: 'Drop the computer from a tall building' } }

    before { put "/bugs/#{bug_id}/steps/#{id}", params: valid_attributes }

    context 'when step exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the step' do
        updated_step = Step.find(id)
        expect(updated_step.name).to match(/Drop the computer from a tall building/)
      end
    end

    context 'when the step does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Step/)
      end
    end
  end

  # Test suite for DELETE /bugs/:id
  describe 'DELETE /bugs/:id' do
    before { delete "/bugs/#{bug_id}/steps/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
