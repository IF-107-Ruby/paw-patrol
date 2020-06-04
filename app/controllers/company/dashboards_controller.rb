class Company
  class DashboardsController < Company::BaseController
    before_action :read_satisfaction_data, only: %i[satisfaction]

    def satisfaction
      if @satisfaction.any?
        render json: @satisfaction
      else
        flash.now[:warning] = 'Satisfaction is empty!'
        render :show
      end
    end

    private

    def read_satisfaction_data
      @satisfaction = []
      (1..5).each do |rating|
        @satisfaction.push(get_amount_of_satisfaction_by_rating(rating))
      end
    end

    def get_amount_of_satisfaction_by_rating(rating)
      ticket_ids = current_company.tickets.split(',')
      {
        name: "Rated #{rating}",
        amount: Review.where(rating: rating, ticket: ticket_ids).count
      }
    end
  end
end
