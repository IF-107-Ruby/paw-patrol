json.id event.id
json.title event.title
json.anchor event.anchor
json.duration event.duration
json.color event.color
json.frequency event.frequency

json.user event.user, as: :user, partial: 'company/events/user'
json.unit @unit, as: :unit, partial: 'company/events/unit'
if event.ticket.present?
  json.ticket event.ticket, as: :ticket, partial: 'company/events/ticket'
end

json.url company_unit_event_path(event.unit, event)
