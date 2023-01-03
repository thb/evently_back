# frozen_string_literal: true

module Api
  module V1
    class EventSerializer < ApplicationSerializer
      attributes :id,
                 :name,
                 :description,
                 :starts_at

      belongs_to :category
      belongs_to :place
    end
  end
end
