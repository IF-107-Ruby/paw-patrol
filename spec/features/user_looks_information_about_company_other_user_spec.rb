require 'rails_helper'

feature 'User looks Information About Company Other User' do
  let(:company) { create(:company) }
  let(:company_owner) { create(:company_owner, company: company) }
  let(:user) { create(:user, company: company) }

  before { login_as company_owner }

  scenario 'successfully' do
    pending('something else getting finished')

    visit user_path(user)

    expect(page).to have_selector('div.company-role')
    click_on company.name

    expect(page).to have_selector('h2',
                                  text: company.name)
    expect(page).to have_selector('a', text: 'Company members')
    click_on 'Company members'

    expect(page).to have_selector('h3', text: 'Members:')

    full_user_name = user.first_name +
                     ' ' + user.last_name
    expect(page).to have_selector('td',
                                  text: full_user_name)
    expect(page).to have_selector('td',
                                  text: user.role
                                                                    .capitalize
                                                                    .gsub('_', ' '))
  end
end
