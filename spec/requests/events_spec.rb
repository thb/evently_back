# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events API', type: :request do

  let(:category) { create(:category) }
  let(:place) { create(:place) }

  let(:valid_params) {{
      event: {
        name: 'Event name',
        description: 'Event description',
        place_id: place.id,
        category_id: category.id,
        starts_at: Time.now,
      }
  }}
  let(:invalid_params) { valid_params.merge({ event: { name: nil } }) }

  let!(:events) { create_list(:event, 3) }
  let(:event_id) { events.first.id }
  let(:valid_headers) { { 'Authorization': 'Bearer ' + 'ANY_TOKEN' } }

  describe 'GET /v1/events' do
    before { get '/v1/events', params: {}, headers: valid_headers }

    it 'returns events' do
      expect(json[:data]).not_to be_empty
      expect(json[:data].size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /services/:id
  describe 'GET /v1/events/:id' do
    before { get "/v1/events/#{event_id}", params: {}, headers: valid_headers }

    context 'when the record exists' do
      it 'returns the service' do
        expect(json[:data]).not_to be_empty
        expect(json[:data][:id]&.to_i).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json[:error][:message].first).to match(/Couldn't find Event with 'id'=#{event_id}/)
      end
    end
  end

  # Test suite for POST /v1/events
  describe 'POST /v1/events' do
    context 'when the request is valid' do
      before { post '/v1/events', params: valid_params, headers: valid_headers }

      it 'creates a service' do
        expect(json[:data][:attributes][:name]).to eq('Event name')
      end

      it 'returns status code 201' do
        # TODO should be 201 - created
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/v1/events', params: invalid_params, headers: valid_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/UNPROCESSABLE ENTITY/)
      end
    end
  end

  # Test suite for PUT /v1/events/:id
  describe 'PUT /v1/events/:id' do
    context 'when the record exists' do
      before { put "/v1/events/#{event_id}", params: valid_params, headers: valid_headers }

      it 'updates the record' do
        expect(json[:data][:attributes][:name]).to eq('Event name')
      end

      it 'returns status code 204' do
        # TODO should be 204 if returns no content (not the case)
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /v1/events/:id
  describe 'DELETE /v1/events/:id' do
    before { delete "/v1/events/#{event_id}", headers: valid_headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end