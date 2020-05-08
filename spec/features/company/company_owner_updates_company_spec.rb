require 'rails_helper'

feature 'Company owner updates company' do
  let(:company_attributes) { attributes_for(:company) }
  let(:user) { create(:company_owner, :with_company) }

  before { login_as user }

  scenario 'successfully' do
    visit company_path

    expect(page).to have_text(user.company.name)

    find('div.icon-links > a').click

    expect(page).to have_text('Company Edit Form')

    fill_in id: 'company_name', with: company_attributes[:name]
    fill_in id: 'company_description', with: company_attributes[:description]
    fill_in id: 'company_email', with: company_attributes[:email]
    fill_in id: 'company_phone', with: company_attributes[:phone]

    click_on class: 'button ripple-effect big margin-top-30'

    expect(page).to have_text(company_attributes[:name])
    expect(page).not_to have_text(user.company.name)
  end

  scenario 'unsuccessfully' do
    visit company_path

    expect(page).to have_text(user.company.name)

    find('div.icon-links > a').click

    expect(page).to have_text('Company Edit Form')

    fill_in id: 'company_name', with: company_attributes[:name]
    fill_in id: 'company_description', with: company_attributes[:description]
    fill_in id: 'company_email', with: company_attributes[:email]
    fill_in id: 'company_phone', with: 'Invalid phone number'

    click_on class: 'button ripple-effect big margin-top-30'

    expect(page).not_to have_text(company_attributes[:name])
    expect(page).to have_text('Company Edit Form')
    expect(page).to have_css('div.alert.alert-danger')
  end
end
