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
end