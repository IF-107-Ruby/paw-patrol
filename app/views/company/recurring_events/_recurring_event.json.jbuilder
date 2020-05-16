date_format = recurring_event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
events = recurring_event.events(params[:start], params[:end])
json.array! events do |event|
  ends_at = event + recurring_event.duration.minutes
  json.id "recurring_event_#{recurring_event.id}"
  json.groupId "recurring_event_#{recurring_event.id}"
  json.title recurring_event.title
  json.type 'recurring event'
  json.start event.strftime(date_format)
  json.end ends_at.strftime(date_format)

  json.color recurring_event.color
  json.allDay recurring_event.all_day_event?

  json.update_url company_unit_recurring_event_path(recurring_event.unit,
                                                    recurring_event,
                                                    method: :patch)
  json.show_url company_unit_recurring_event_path(recurring_event.unit, recurring_event)
end
