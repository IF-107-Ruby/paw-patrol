json.id ticket.id
json.name ticket.name
json.user ticket.user, as: :user, partial: 'api/v1/tickets/user'
if ticket.responsible_user.present?
  json.responsible_user ticket.responsible_user, as: :user, partial: 'api/v1/tickets/user'
end
json.unit ticket.unit, as: :unit, partial: 'api/v1/tickets/unit'
json.description ticket.description.body
json.updated_at ticket.updated_at
json.created_at ticket.created_at
json.html_url company_ticket_url(ticket)
