json.id unit.id
json.name unit.name
json.hasChildren unit.children?

json.created_at unit.created_at
json.updated_at unit.updated_at

json.ancestry unit.ancestry

json.responsible_user do
  if unit.responsible_user.present?
    json.id unit.responsible_user.id
    json.first_name unit.responsible_user.first_name
    json.last_name unit.responsible_user.last_name
    json.role unit.responsible_user.role
  else
    json.null!
  end
end

json.employees_count unit.users.count

json.url company_unit_path(unit)
