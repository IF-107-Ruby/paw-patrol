class RoomEmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_unit_by_id, only: :index

  def index
    @unit_name = @unit.name
    @pagy, @room_employees = pagy_decorated(find_unit_by_id.users, items: 5)
  end
  
  private

  def find_unit_by_id
    @unit = authorize(current_company.units.find(params[:unit_id]))
  end
  
end
