require 'rails_helper'

feature 'Company owner set responsible user' do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:responsible_user) { create(:staff_member, company: company).decorate }
  let(:unit_params) { attributes_for(:unit) }

  before :each do
    login_as company_owner
  end

  scenario 'Successfully set responsible user' do
    visit new_company_unit_path

    fill_in id: 'unit_name', with: unit_params[:name]
    find(:select, 'unit_responsible_user_id')
      .first(:option, responsible_user.decorate.full_name)
      .select_option

    find('button', class: 'button ripple-effect button-sliding-icon big').click

    expect(page).to have_text('Unit created successfully.')
    expect(page).to have_content(unit_params[:name])
    expect(page).to have_text("#{responsible_user.full_name} is responsible")
  end

  scenario 'Successfully update responsible user' do
    visit company_unit_path(unit)

    find_link(href: edit_company_unit_path(unit)).click

    expect(page).to have_text("Update #{unit.name}")

    find(:select, 'unit_responsible_user_id')
      .first(:option, responsible_user.decorate.full_name)
      .select_option

    find('button', class: 'button ripple-effect button-sliding-icon big').click

    expect(page).to have_text('Unit updated successfully.')
    expect(page).to have_text("#{responsible_user.full_name} is responsible")
  end
end
