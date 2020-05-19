class Company
  class EventsController < Company::BaseController
    before_action :obtain_unit
    before_action :obtain_event, only: %i[show update destroy]
    helper_method :avaible_tickets

    def index
      @events = selected_events
      authorize([:company, @events])
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
      @event = @unit.events.build(event_params)
      authorize([:company, @event])
      respond_to do |format|
        format.js
      end
    end

    def create
      @event = @unit.events.build(event_params)
      authorize([:company, @event])
      @event.save
      respond_to do |format|
        format.js
      end
    end

    def update
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
      params.fetch(:event, { anchor: Time.zone.now })
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

    def obtain_event
      @event = @unit.events.find(params[:id]).decorate
      authorize([:company, @event])
    end

    def units_base_relation
      current_company.units
    end

    def selected_events
      @unit.events.one_time
           .where('anchor <= ?', params[:end])
           .or(@unit.events.recurring)
    end
  end
end
