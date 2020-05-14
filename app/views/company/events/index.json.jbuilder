json.array! @events do |event|
  date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.title
  json.start event.start.strftime(date_format)
  json.end event.end.strftime(date_format)

  json.color event.color if event.color.present?
  json.allDay event.all_day_event?

  json.show_url company_unit_event_url(event.unit, event)
  json.update_url company_unit_event_url(event.unit, event, method: :patch)
  json.edit_url edit_company_unit_event_url(event.unit, event)
end
