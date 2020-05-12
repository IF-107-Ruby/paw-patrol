class Company
  class ReviewsController < Company::BaseController
    def index
      @tickets = current_user.tickets
    end
  end
end
