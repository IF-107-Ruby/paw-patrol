RSpec.shared_context 'company with users' do
  let!(:company) { create(:company) }

  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:employee) { create(:employee, company: company) }
  let!(:staff_member) { create(:staff_member, company: company) }
end
