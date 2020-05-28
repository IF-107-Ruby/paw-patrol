class Company
  class EventsController < Company::BaseController
    before_action :obtain_unit
    before_action :obtain_event, only: %i[show update destroy]

    def index
      authorize(%i[company event])
      @events = selected_events.includes(:user, :ticket)
      respond_to do |format|
        format.json
      end
    end

    def show
      respond_to do |format|
        format.json
      end
    end

    def create
      @event = @unit.events.build(event_params)
      authorize([:company, @event])

      status_code = if @event.save
                      :created
                    else
                      :unprocessable_entity
                    end

      respond_to do |format|
        format.json { render :create, status: status_code }
      end
    end

    def update
      @event.update(event_params)
      respond_to do |format|
        format.json
      end
    end

    def destroy
      @event.destroy
      respond_to do |format|
        format.json
      end
    end

    def avaible_tickets
      respond_to do |format|
        format.json
      end
    end

    private

    def event_params
      params.fetch(:event, { anchor: Time.zone.now })
            .permit(:title, :anchor, :duration, :frequency, :ticket_id, :color)
            .merge(user: current_user)
    end

    def obtain_unit
      @unit = units_base_relation.find(params[:unit_id])
      authorize([:company, @unit], :show?)
    end

    def obtain_event
      @event = @unit.events.find(params[:id])
      authorize([:company, @event])
    end

    def units_base_relation
      current_company.units
    end

    def selected_events
      @selected_events ||= @unit.events.one_time
                                .where('anchor <= ?', params[:end])
                                .or(@unit.events.recurring)
    end
  end
end
