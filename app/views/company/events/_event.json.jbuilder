date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
occurences = event.events(params[:start], params[:end])
json.array! occurences do |occurence|
  ends_at = occurence + event.duration.minutes
  json.id "event_#{event.id}"
  json.groupId "event_#{event.id}"
  json.title event.title
  json.start occurence.strftime(date_format)
  json.end ends_at.strftime(date_format)

  json.color event.color
  json.allDay event.all_day_event?

  json.event_url company_unit_event_path(event.unit, event)
end
