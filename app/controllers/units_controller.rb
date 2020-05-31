class UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :read_unit_by_id, only: %i[show edit update destroy]
  layout 'hireo', only: %i[new create edit update]

  helper_method :available_responsible_users

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
    @unit = authorize(current_company.units.find(params[:id])).decorate
  end

  def available_responsible_users
    @available_responsible_users ||= current_company.staff
  end
end
