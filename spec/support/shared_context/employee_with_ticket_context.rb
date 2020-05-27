RSpec.shared_context 'employee with ticket' do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit,
                       :with_employee_and_ticket,
                       :with_responsible_user,
                       company: company) }
  let!(:employee) { unit.users.first }
  let!(:ticket) { unit.tickets.first }
end
