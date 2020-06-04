class Company
  class DashboardsController < Company::BaseController
    before_action :read_satisfaction_data, only: %i[satisfaction]

    def show
      if current_user.staff_member? || current_user.employee?
        load_worker_data
      elsif current_user.company_owner?
        @company_statistics = [{ subtitle: 'Workers',
                                 value: current_company.employees.count },
                               { subtitle: 'Responsible users',
                                 value: current_company.responsible_users.count }]
    end

    def satisfaction
      if @satisfaction.any?
        render json: @satisfaction
      else
        flash.now[:warning] = 'Satisfaction is empty!'
        render :show
      end
    end

    private

    def load_worker_data
      @current_tickets = current_user.current_tickets
                                     .most_recent
                                     .limit(7)
                                     .decorate
      @resolved_tickets = current_user.resolved_tickets
                                      .most_recent
                                      .limit(7)
                                      .decorate
    end

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
