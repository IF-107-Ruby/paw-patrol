class UnitsController < ApplicationController
  def index
    @units = Unit.all
  end

  def show
    @unit = read_unit_by_id
  end

  def new
    @unit = Unit.new
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

  def edit
    @unit = read_unit_by_id
  end

  def update
    @unit = read_unit_by_id
    if @unit.update_attributes(unit_params)
      flash[:success] = 'Unit information updated.'
      redirect_to @unit
    else
      flash[:danger] = 'Unit updating failed.'
      render 'edit'
    end
  end

  def destroy
    @unit = read_unit_by_id
    if @unit.destroy
      flash[:success] = 'Unit deleted successfully.'
      redirect_to units_path
    else
      flash[:danger] = 'Cannot delete unit.'
      render 'show'
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:name)
  end

  def read_unit_by_id
    Unit.find(params[:id])
  end
end
