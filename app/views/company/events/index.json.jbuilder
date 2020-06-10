@events.each do |event|
  date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  occurences = event.events(params[:start], params[:end])
  json.array! occurences do |occurence|
    ends_at = occurence + event.duration.minutes
    json.id event.id
    json.groupId event.id
    json.title event.title
    json.frequency event.frequency
    json.start occurence.strftime(date_format)
    json.end ends_at.strftime(date_format)

    json.color event.color
    json.allDay event.all_day_event?

    json.event_url company_unit_event_path(event.unit, event)

    json.user event.user, as: :user, partial: 'company/events/user'
    json.unit @unit, as: :unit, partial: 'company/events/unit'
    if event.ticket.present?
      json.ticket event.ticket, as: :ticket, partial: 'company/events/ticket'
    end
  end
end
