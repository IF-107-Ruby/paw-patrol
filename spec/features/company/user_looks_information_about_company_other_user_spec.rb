require 'rails_helper'

feature 'User looks information about company other user' do
  include_context 'company with users'

  before { login_as employee }

  scenario 'successfully' do
    visit company_path

    click_on company.decorate.users_count

    expect(page).to have_text('Members')

    expect(page).to have_text(company_owner.decorate.full_name)
    click_on company_owner.first_name

    expect(page).to have_selector('h3', text: company_owner.decorate.full_name)
  end
end
