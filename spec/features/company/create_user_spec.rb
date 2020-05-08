require 'rails_helper'

feature 'users' do
  let(:user_params) { attributes_for(:staff_member) }
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let(:employee) { create(:employee, company: company) }

  before { login_as company_owner }

  scenario 'successfully creates a user' do
    visit new_company_user_path

    fill_in id: 'user_first_name', with: user_params[:first_name]
    fill_in id: 'user_last_name', with: user_params[:last_name]
    fill_in id: 'user_email', with: user_params[:email]
    fill_in id: 'user_password', with: user_params[:password]
    fill_in id: 'user_password_confirmation', with: user_params[:password]
    choose(id: 'user_role_staff_member')

    find('button', class: 'button ripple-effect button-sliding-icon big').click

    expect(page).to have_text('Company member created.')

    expect(page).to have_content(user_params[:first_name])
    expect(page).to have_content('Staff member')
  end

  scenario 'successfully updates a user' do
    visit company_user_path(employee)

    find_link(href: edit_company_user_path(employee)).click

    expect(page).to have_text('Update company member')

    fill_in id: 'user_first_name', with: user_params[:first_name]
    fill_in id: 'user_last_name', with: user_params[:last_name]
    fill_in id: 'user_email', with: user_params[:email]
    choose(id: 'user_role_staff_member')

    find('button', class: 'button ripple-effect button-sliding-icon big').click

    expect(page).to have_text('User profile updated')
    expect(page).to have_content(user_params[:first_name])
  end

  scenario 'successfully deletes a user' do
    visit company_user_path(employee)

    within('.icon-links') do
      find('a[data-method="delete"]').click
    end
    expect(page).to have_text('Company member was deleted')
    expect(page).not_to have_content(employee.first_name)
  end
end
