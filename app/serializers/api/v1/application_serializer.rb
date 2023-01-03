# frozen_string_literal: true

module Api
  module V1
    class ApplicationSerializer
      include JSONAPI::Serializer
      set_key_transform :camel_lower

      def self.detail?(key = :detail)
        self.has_any_key?(key)
      end

      def self.has_any_key?(*keys)
        proc { |_, params| params && keys.any? { |key| params[key].present? }}
      end

      def self.has_all_key?(*keys)
        proc { |_, params| params && keys.all? { |key| params[key].present? }}
      end
    end
  end
end