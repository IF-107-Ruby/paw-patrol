json.array! @events do |event|
  date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.title
  json.start event.starts_at.strftime(date_format)
  json.end event.ends_at.strftime(date_format)

  json.color event.color if event.color.present?
  json.allDay event.all_day_event?

  json.show_url company_unit_event_url(event.unit, event)
  json.update_url company_unit_event_url(event.unit, event, method: :patch)
end