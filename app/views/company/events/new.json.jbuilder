json.title @event.title
json.anchor @event.anchor
json.duration @event.duration
json.color @event.color
json.ticket_id @event.ticket_id
json.frequency @event.frequency
json.user_id @event.user_id

json.errors @event.errors if @event.errors.any?

json.url company_unit_events_path(@unit, format: :json)
