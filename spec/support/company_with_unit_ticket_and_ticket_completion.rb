RSpec.shared_context 'company with unit, ticket and ticket completion' do
  let!(:company) { create(:company) }

  let!(:unit) do
    create(:unit,
           :with_responsible_user,
           :with_employee_and_ticket,
           company: company)
  end

  let!(:ticket_completion) do
    create(:ticket_completion,
           user: unit.responsible_user,
           ticket: unit.tickets.last)
  end
end
