class UnitsController < ApplicationController
  before_action :read_company_by_id
  before_action :read_unit_by_id, only: %i[show edit update destroy]

  def index
    @pagy, @units = pagy(@company.units, items: 10)
  end

  def show; end

  def new
    @unit = @company.units.build(parent_id: params[:parent_id])
  end

  def create
    @unit = @company.units.build(unit_params)
    if @unit.save
      flash[:success] = 'Unit created successfully.'
      redirect_to company_unit_path(@company, @unit)
    else
      flash[:danger] = 'Unit creation failed.'
      render 'new'
    end
  end

  def edit; end

  def update
    if @unit.update(unit_params)
      flash[:success] = 'Unit information updated.'
      redirect_to company_unit_path(@company)
    else
      flash[:danger] = 'Unit updating failed.'
      render 'edit'
    end
  end

  def destroy
    @unit.destroy
    flash[:success] = 'Unit deleted successfully.'
    redirect_to company_units_path(@company)
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :parent_id)
  end

  def read_unit_by_id
    @unit = @company.units.where(id: params[:id]).first
    render 'errors/not_found' unless @unit
  end

  def read_company_by_id
    @company = Company.where(id: params[:company_id]).first
    render 'errors/not_found' unless @company
  end
end
