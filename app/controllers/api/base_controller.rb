module Api
  class BaseController < ::ApplicationController
    before_action :check_token

    attr_reader :current_user

    private

    def check_token
      authenticate_or_request_with_http_token do |token|
        @current_user = User.find_by(access_token: token, access_token_enabled: true)
        @current_user.present?
      end
    end
  end
end
