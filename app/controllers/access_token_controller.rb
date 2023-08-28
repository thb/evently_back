class AccessTokenController < Doorkeeper::TokensController
  include ActionController::Cookies

  before_action :set_refresh_token, if: :is_refreshing_token?

  def create
    super
    return unless request.headers['x-use-cookie'] === 'true'
    if response.successful?
      token = authorize_response.token
      cookies[:access_token] = { value: token.token, httponly: true, secure: true }
      cookies[:refresh_token] = { value: token.refresh_token, httponly: true, secure: true }
      self.response_body = { id: token.resource_owner_id }.to_json
    elsif is_refreshing_token?
      cookies.delete(:access_token)
    end
  end

  def revoke
    super.tap {
      if response.successful?
        cookies.delete(:access_token)
        cookies.delete(:refresh_token)
      end
    }
  end
  
  def is_refreshing_token?
    params[:grant_type] == 'refresh_token'
  end

  def set_refresh_token
    return unless request.headers['x-use-cookie'] === 'true'
    strategy.parameters[:refresh_token] = cookies[:refresh_token]
  end


end
