require 'rails_helper'

RSpec.describe UserDecorator do
  include_context 'employee with ticket'

  let(:decorated_employee) { employee.decorate }
  let(:responsible_user) { unit.responsible_user }
  let(:responsible_user_decorated) { responsible_user.decorate }

  it 'full user name' do
    expected = employee.first_name + ' ' + employee.last_name
    expect(decorated_employee.full_name).to eq(expected)
  end

  it 'created tickets count' do
    tickets_count = employee.tickets.count
    expected = "#{tickets_count} ticket".pluralize(tickets_count)
    expect(decorated_employee.created_tickets_count).to eq(expected)
  end

  it 'resolved tickets count' do
    tickets_count = responsible_user.resolved_tickets.count
    expected = "#{tickets_count} ticket".pluralize(tickets_count)
    expect(responsible_user_decorated.resolved_tickets_count).to eq(expected)
  end
end
