class Company
  class UnitsController < Company::BaseController
    before_action :obtain_unit, only: %i[show edit update destroy]
    helper_method :available_responsible_users
    decorates_assigned :unit

    def index
      authorize([:company, Unit])
      @pagy, @units = pagy_decorated(units_base_relation.roots, items: 10)
    end

    def show
      @children_pagy, @unit_children = pagy_decorated(@unit.children,
                                                      items: 5,
                                                      page_param: :page_children)
      @tickets_pagy, @unit_tickets = pagy_decorated(@unit.tickets.most_recent,
                                                    items: 5,
                                                    page_param: :page_tickets)
    end

    def new
      @unit = units_base_relation.build(parent_id: params[:parent_id]).decorate
      authorize([:company, @unit])
    end

    def create
      @unit = units_base_relation.build(unit_params).decorate
      authorize([:company, @unit])
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
      params.require(:unit).permit(:name, :parent_id, :responsible_user_id)
    end

    def obtain_unit
      @unit = units_base_relation.find(params[:id])
      authorize([:company, @unit])
    end

    def available_responsible_users
      @available_responsible_users ||= current_company.staff.decorate
    end

    def units_base_relation
      current_company.units
    end
  end
end
