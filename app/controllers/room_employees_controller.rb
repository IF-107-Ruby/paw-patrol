class RoomEmployeesController < ApplicationController
  before_action :find_unit_by_id, only: :index

  def index
    @unit_name = @unit.name
    @pagy, @room_employees = pagy_decorated(@unit.users, items: 5)
  end

  private

  def find_unit_by_id
    @unit = Unit.find(params[:unit_id])
  end
end
