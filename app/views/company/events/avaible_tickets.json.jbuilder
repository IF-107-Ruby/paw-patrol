json.array! @unit.tickets.select(:id, :name) do |ticket|
  json.id ticket.id
  json.name ticket.name
end
