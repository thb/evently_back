module Api
  module V1
    class EventsController < ApiController
      before_action :set_event, only: %i[update show destroy]

      def index
        events = Event.all
        options = {}
        #options[:include] = %i[category place]
        render_json(
          serializer, 
          events,
          options
        )
      end

      def show
        render_json(
          serializer,
          @event,
          include: detail_includes,
          params: { detail: true }
        )
      end

      private
      
      def serializer
        ::Api::V1::EventSerializer
      end

      def detail_includes
        []
      end

      def set_event
        @event = Event.find(params[:id])
      end

    end
  end
end