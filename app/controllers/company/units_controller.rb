class Company
  class UnitsController < Company::BaseController
    before_action :obtain_unit, only: %i[show children edit update destroy]

    def index
      authorize([:company, Unit])
      @pagy, @units = pagy_decorated(units_base_relation.roots, items: 10)
    end

    def show
      @pagy, @unit_children = pagy_decorated(@unit.children, items: 20)
    end

    def children
      respond_to do |format|
        format.js
      end
    end

    def new
      unit = units_base_relation.build(parent_id: params[:parent_id])
      _, @unit = authorize([:company, unit.decorate])
    end

    def create
      unit = units_base_relation.build(unit_params)
      _, @unit = authorize([:company, unit.decorate])
      if @unit.save
        flash[:success] = 'Unit created successfully.'
        redirect_to [:company, @unit]
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @unit.update(unit_params)
        flash[:success] = 'Unit updated successfully.'
        redirect_to [:company, @unit]
      else
        render 'edit'
      end
    end

    def destroy
      @unit.destroy
      flash[:success] = 'Unit deleted successfully.'
      redirect_back(fallback_location: company_units_path)
    end

    private

    def unit_params
      params.require(:unit).permit(:name, :parent_id)
    end

    def obtain_unit
      _, @unit = authorize([:company, units_base_relation.find(params[:id]).decorate])
    end

    def units_base_relation
      current_company.units
    end
  end
end
