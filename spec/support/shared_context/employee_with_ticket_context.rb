RSpec.shared_context 'employee with ticket' do
  let!(:company) { create(:company) }
  let!(:unit) do
    create(:unit,
           :with_employee_and_ticket,
           :with_responsible_user,
           company: company)
  end
  let!(:employee) { unit.users.first }
  let!(:ticket) { unit.tickets.first }
  let!(:resolved_ticket) do
    create(:resolved_ticket,
           user: employee,
           unit: unit)
  end
end
