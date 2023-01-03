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
end