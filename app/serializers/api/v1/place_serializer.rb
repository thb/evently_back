# frozen_string_literal: true

module Api
  module V1
    class PlaceSerializer < ApplicationSerializer
      attributes :id,
                 :name

      has_many :events
    end
  end
end
