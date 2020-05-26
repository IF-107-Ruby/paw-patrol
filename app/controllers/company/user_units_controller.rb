class Company
  class UserUnitsController < Company::BaseController
    before_action :obtain_unit, only: :show
    decorates_assigned :unit

    def index
      authorize([:company, Unit])
      @pagy, @units = pagy_decorated(current_user.units, items: 10)
    end

    def show
      @tickets_pagy, @unit_tickets = pagy_decorated(@unit.tickets.most_recent,
                                                    items: 5,
                                                    page_param: :page_tickets)
    end

    private

    def obtain_unit
      @unit = units_base_relation.find(params[:id])
      authorize([:company, @unit])
    end

    def units_base_relation
      current_company.units
    end
  end
end
