module Api
  class ApiController < ActionController::API

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def render_json(serializer, obj, options={})
      if obj.class.name == 'ActiveRecord::Relation'
        return render_collection(serializer, obj, options)
      end

      render_record(serializer, obj, options)
    end
  
    def render_collection(serializer, collection, options={})
      #options = meta_pagination(collection, options)
      render_record(serializer, collection, options)
    end

    def render_record(serializer, record, options={})
      render json: serializer.new(record, options)
    end
    
    def errors_json(messages, code)
      render json: {
        error: {
          code: code,
          message: [messages].flatten,
          status: Rack::Utils::HTTP_STATUS_CODES[code].upcase
        }
      }, status: code
    end

    def record_not_found(error)
      desc = Rails.env.production? ? 'Record not found.' : error.message
      errors_json(desc, 404)
    end

    def user_not_authorized
      errors_json('You are not authorized to perform this action.', 403)
    end
  end
end