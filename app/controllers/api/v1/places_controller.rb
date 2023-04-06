module Api
  module V1
    class PlacesController < ApiController
      before_action :set_place, only: %i[update show destroy]

      def index
        places = Place.all
        options = {}
        options[:include] = %w[events events.category]
        render_json(
          serializer, 
          places,
          options
        )
      end

      def show
        render_json(
          serializer,
          @place,
          include: detail_includes,
          params: { place_detail: true }
        )
      end

      def create
        place = Place.new(place_params)
        if place.save
          render_json(
            serializer,
            place,
            include: detail_includes,
            params: { place_detail: true }
          )
        else
          errors_json(place.errors.full_messages, 422)
        end
      end

      def update
        if @place.update(place_params)
          render_json(
            serializer,
            @place,
            include: detail_includes,
            params: { place_detail: true }
          )
        else
          errors_json(@place.errors.full_messages, 422)
        end
      end

      def destroy
        @place.destroy
        head 204
      end

      private
      
      def serializer
        ::Api::V1::PlaceSerializer
      end

      def detail_includes
        %w[]
      end

      def set_place
        @place = Place.find(params[:id])
      end

      def place_params
        params
          .require(:place)
          .permit(:name, :description, :starts_at, ends_at, :category_id, :place_id)
      end

    end
  end
end