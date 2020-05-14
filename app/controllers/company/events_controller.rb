class Company
  class EventsController < Company::BaseController
    before_action :obtain_unit
    before_action :obtain_event, only: %i[show update destroy]
    helper_method :avaible_tickets

    def index
      @events = selected_events
      respond_to do |format|
        format.json
      end
    end

    def show
      respond_to do |format|
        format.js
      end
    end

    def new
      @event = @unit.events.build
      respond_to do |format|
        format.js
      end
    end

    def create
      @event = @unit.events.build(event_params)
      @event.save
      respond_to do |format|
        format.js { formats << :json }
      end
    end

    def update
      @event = @unit.events.find(params[:id])
      @event.update(event_params)
      respond_to do |format|
        format.js
      end
    end

    def destroy
      @event.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def event_params
      params.require(:event)
            .permit(:title, :ticket_id, :starts_at, :ends_at, :color)
            .merge(user: current_user)
    end

    def avaible_tickets
      @unit.tickets
    end

    def obtain_unit
      @unit = units_base_relation.find(params[:unit_id])
      authorize([:company, @unit])
    end

    def obtain_event
      @event = @unit.events.find(params[:id]).decorate
    end

    def units_base_relation
      current_company.units
    end

    def selected_events
      @unit.events
           .where(starts_at: params[:start]..params[:end])
           .or(@unit.events
        .where(ends_at: params[:start]..params[:end]))
    end
  end
end
