class Company
  class UnitsChildrenController < Company::BaseController
    before_action :obtain_unit, only: [:index]
    after_action :add_pagy_headers, only: :index
    decorates_assigned :unit

    def index
      @pagy, @units = pagy(@unit.children, items: 10)
      respond_to do |format|
        format.json
      end
    end

    private

    def obtain_unit
      @unit = units_base_relation.find(params[:unit_id])
      authorize([:company, @unit])
    end

    def units_base_relation
      current_company.units
    end
  end
end
