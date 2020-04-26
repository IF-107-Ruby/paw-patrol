class RoomEmployeesController < ApplicationController
  before_action :find_unit_by_id, only: :index

  def index
    @unit_name = @unit.name
    @room_employees = @unit.users
  end

  private

  def find_unit_by_id
    @unit = Unit.find(params[:unit_id])
  end
end
