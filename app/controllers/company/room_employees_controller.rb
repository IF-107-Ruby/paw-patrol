class Company
  class RoomEmployeesController < Company::BaseController
    before_action :find_unit_by_id

    def show
      @pagy, @room_employees = pagy_decorated(@unit.users, items: 10)
    end

    def edit
      @available_employees = [['Employees', current_company.employees],
                              ['Staff members', current_company.staff]]
    end

    def update
      if @unit.update(employee_params)
        flash[:success] = 'Employees updated!'
        redirect_to [:company, @unit, :room_employees]
      else
        render 'edit'
      end
    end

    private

    def find_unit_by_id
      @unit = current_company.units.find(params[:unit_id]).decorate
      authorize([:company, @unit])
    end

    def employee_params
      params
        .require(:unit)
        .permit(:id, user_ids: [])
    end
  end
end
