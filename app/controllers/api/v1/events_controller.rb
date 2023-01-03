module Api
  module V1
    class EventsController < ApiController

      def index
        events = Event.all
        options = {}
        options[:include] = %i[category place]
        render_json(
          serializer, 
          events,
          options
        )
      end

      private
      
      def serializer
        ::Api::V1::EventSerializer
      end
    end
  end
end