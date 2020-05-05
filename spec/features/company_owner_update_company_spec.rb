require 'rails_helper'

feature 'Company owner update company' do
  let!(:company_owner) { create(:company_owner, :with_company) }

  before { login_as company_owner }

  scenario 'successfully' do
    visit company_edit_path
    fill_in id: 'company_name', with: 'Updated company name'

    click_on class: 'button ripple-effect big margin-top-30'

    expect(page).to have_text('Company profile has been updated.')
    expect(page).to have_css('h3', text: 'Updated company name')
  end

  scenario 'unsuccessfully' do
    visit company_edit_path
    fill_in id: 'company_phone', with: 'Invalid phone number'

    click_on class: 'button ripple-effect big margin-top-30'

    expect(page).not_to have_text('Company profile has been updated.')
  end
end
