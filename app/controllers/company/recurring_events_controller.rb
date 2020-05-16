class Company
  class RecurringEventsController < Company::BaseController
    before_action :obtain_unit
    before_action :obtain_recurring_event, only: %i[show update destroy]
    helper_method :avaible_tickets

    def index
      @recurring_events = @unit.recurring_events
      authorize([:company, @recurring_events])
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
      @recurring_event = @unit.recurring_events.build(recurring_event_params)
      authorize([:company, @recurring_event])
      respond_to do |format|
        format.js
      end
    end

    def create
      @recurring_event = @unit.recurring_events.build(recurring_event_params)
      authorize([:company, @recurring_event])
      @recurring_event.save
      respond_to do |format|
        format.js
      end
    end

    def update
      @recurring_event.update(recurring_event_params)
      respond_to do |format|
        format.js
      end
    end

    def destroy
      @recurring_event.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def recurring_event_params
      params.fetch(:recurring_event, {})
            .permit(:title, :anchor, :duration, :frequency, :ticket_id, :color)
            .merge(user: current_user)
    end

    def avaible_tickets
      @unit.tickets
    end

    def obtain_unit
      @unit = units_base_relation.find(params[:unit_id])
      authorize([:company, @unit], :show?)
    end

    def obtain_recurring_event
      @recurring_event = @unit.recurring_events.find(params[:id]).decorate
      authorize([:company, @recurring_event])
    end

    def units_base_relation
      current_company.units
    end
  end
end
