require 'rails_helper'

feature 'User looks Information About Company Other User' do
  let(:users_companies_relationship) { create(:users_companies_relationship) }

  before { login_as users_companies_relationship.user }

  scenario 'successfully' do
    visit user_path(users_companies_relationship.user)

    expect(page).to have_selector('div.company-role')
    click_on users_companies_relationship.company.name

    expect(page).to have_selector('h2',
                                  text: users_companies_relationship.company.name)
    expect(page).to have_selector('a', text: 'Company members')
    click_on 'Company members'

    expect(page).to have_selector('h3', text: 'Members:')

    full_user_name = users_companies_relationship.user.first_name +
                     ' ' + users_companies_relationship.user.last_name
    expect(page).to have_selector('td',
                                  text: full_user_name)
    expect(page).to have_selector('td',
                                  text: users_companies_relationship.role
                                                                    .capitalize
                                                                    .gsub('_', ' '))
  end
end
