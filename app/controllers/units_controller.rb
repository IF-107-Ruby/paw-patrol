class UnitsController < ApplicationController
  before_action :read_unit_by_id, only: %i[show edit update destroy]

  def index
    @pagy, @units = pagy(Unit.all, items: 10)
  end

  def show; end

  def new
    @unit = Unit.new(parent_id: params[:parent_id])
  end

  def create
    @unit = Unit.create(unit_params)
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
    if @unit.destroy
      flash[:success] = 'Unit deleted successfully.'
      redirect_to units_path
    else
      flash[:danger] = 'Cannot delete unit.'
      render unit_path(@unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :parent_id)
  end

  def read_unit_by_id
    @unit = Unit.find(params[:id])
  end
end
