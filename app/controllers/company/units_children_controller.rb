class Company
  class UnitsChildrenController < ApplicationController
    before_action :obtain_unit, only: [:index]
    decorates_assigned :unit

    def index
      respond_to do |format|
        format.js
      end
    end

    private

    def obtain_unit
      @unit = units_base_relation.find(params[:unit_id])
      authorize([:company, @unit])
    end

    def units_base_relation
      current_company.units
    end
  end
end
