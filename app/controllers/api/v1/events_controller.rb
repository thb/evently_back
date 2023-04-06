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
          params: { event_detail: true }
        )
      end

      def create
        event = Event.new(event_params)
        if event.save
          render_json(
            serializer,
            event,
            include: detail_includes,
            params: { event_detail: true }
          )
        else
          errors_json(event.errors.full_messages, 422)
        end
      end

      def update
        if @event.update(event_params)
          render_json(
            serializer,
            @event,
            include: detail_includes,
            params: { event_detail: true }
          )
        else
          errors_json(@event.errors.full_messages, 422)
        end
      end

      def destroy
        @event.destroy
        head 204
      end

      private
      
      def serializer
        ::Api::V1::EventSerializer
      end

      def detail_includes
        %w[category place]
      end

      def set_event
        @event = Event.find(params[:id])
      end

      def event_params
        params
          .require(:event)
          .permit(:name, :description, :starts_at, :ends_at, :category_id, :place_id)
      end

    end
  end
end