class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :require_api_token

  private
    # Deny by default: every action needs "Authorization: Bearer <API_TOKEN>" unless
    # its controller opts out with skip_before_action. API_TOKEN comes from the
    # environment; when it is not set, every protected action is refused.
    def require_api_token
      expected = ENV["API_TOKEN"].to_s
      authorized = expected.present? &&
        authenticate_with_http_token { |token, _options| ActiveSupport::SecurityUtils.secure_compare(token, expected) }

      head :unauthorized unless authorized
    end
end
