require 'rails_helper'

feature 'Company owner set responsible user' do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner_relationship, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:responsible_user) { create(:staff_member, :with_company, company: company) }

  before :each do
    login_as company_owner.user
  end

  scenario 'Successfully set responsible user' do
    visit new_unit_path
    fill_in 'Unit name', with: 'Created unit name'
    find(:select, 'unit_responsible_user_id')
      .first(:option, responsible_user.decorate.full_name)
      .select_option
    click_on 'Create Unit'
    expect(page).to have_text('Unit created successfully.')
    expect(page).to have_text('Responsible for unit')
    expect(page).to have_text(responsible_user.decorate.full_name)
  end

  scenario 'Successfully update responsible user' do
    visit edit_unit_path(unit)
    fill_in 'Unit name', with: 'Updated unit name'
    find(:select, 'unit_responsible_user_id')
      .first(:option, responsible_user.decorate.full_name)
      .select_option
    click_on 'Save changes'
    expect(page).to have_text('Unit information updated.')
    expect(page).to have_text('Responsible for unit')
    expect(page).to have_text(responsible_user.decorate.full_name)
  end
end
