require 'rails_helper'

feature 'User visits company path' do
  let(:user) { create(:user, :with_company) }

  scenario 'successfully' do
    login_as user
    visit company_path
    expect(page.status_code).to eq(200)
    expect(page).to have_text(user.company.name)
    expect(page).to have_text(user.company.email)
    expect(page).to have_text(user.company.description)
  end
end
