class UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :read_unit_by_id, only: %i[show edit update destroy]
  before_action :available_responsible_users, only: %i[new create edit update]
  layout 'hireo', only: %i[new create edit update]

  def index
    @pagy, @units = pagy(current_company.units, items: 10)
  end

  def show; end

  def new
    @unit = authorize(current_company.units.build(parent_id: params[:parent_id]))
  end

  def create
    @unit = current_company.units.build(unit_params)
    if @unit.save
      flash[:success] = 'Unit created successfully.'
      redirect_to @unit
    else
      flash[:danger] = 'Unit creation failed.'
      render 'new'
    end
  end

  def edit; end

  def update
    if @unit.update(unit_params)
      flash[:success] = 'Unit information updated.'
      redirect_to @unit
    else
      flash[:danger] = 'Unit updating failed.'
      render 'edit'
    end
  end

  def destroy
    @unit.destroy
    flash[:success] = 'Unit deleted successfully.'
    redirect_to units_path
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :parent_id, :responsible_user_id)
  end

  def read_unit_by_id
    @unit = authorize(current_company.units.find(params[:id]))
  end

  def available_responsible_users
    @available_responsible_users ||= current_company.users
                                                    .where({ role: 'staff_member' })
                                                    .map do |u|
      [u.decorate.full_name, u.id]
    end
  end
end
