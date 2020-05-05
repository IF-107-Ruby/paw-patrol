class Company
  class BaseController < ::ApplicationController
    layout 'hireo_dashboard'

    def authorize(record, query = nil)
      super([:company, record], query)
    end
  end
end
