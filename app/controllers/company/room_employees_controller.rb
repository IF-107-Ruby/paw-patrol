class Company
  class RoomEmployeesController < Company::BaseController
    before_action :find_unit_by_id, only: :index

    def index
      @pagy, @room_employees = pagy_decorated(@unit.users, items: 10)
    end

    private

    def find_unit_by_id
      @unit = current_company.units.find(params[:unit_id]).decorate
      authorize([:company, @unit])
    end
  end
end
