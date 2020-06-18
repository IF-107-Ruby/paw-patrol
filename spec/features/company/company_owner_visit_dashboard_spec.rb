require 'rails_helper'

feature 'company owner visit dashboard' do
  include_context 'company with users'
  let!(:unit) do
    create(:unit,
           :with_responsible_user,
           :with_employees_and_tickets,
           company: company)
  end

  before { login_as company_owner }

  scenario 'successfully', js: true do
    visit company_dashboard_path

    expect(page).to have_text('Workers')
    expect(page).to have_text('Responsible users')
    expect(page).to have_text('Rewiew satisfaction')

    within('.basic-table') do
      company.tickets.open.most_recent.limit(10).each do |ticket|
        expect(page).to have_css('td > a', text: ticket.name, visible: :all)
      end
    end

    within('.recharts-wrapper') do
      CompanyDashboard.new(company).review_rates.each do |rate|
        expect(page).to have_css('tspan', text: rate[:name], visible: :all)
      end
    end
  end
end
