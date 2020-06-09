module Api
  class BaseController < ::ApplicationController
    before_action :check_token

    private

    def check_token
      authenticate_or_request_with_http_token do |token|
        @company = Company.find_by(access_token: token)
        @company.present?
      end
    end
  end
end
