RSpec.shared_context 'unit with ticket and resolution' do
  let!(:company) { create(:company) }

  let!(:unit) do
    create(:unit,
           :with_responsible_user,
           :with_employee_and_ticket,
           company: company)
  end
end
