require 'rails_helper'

feature 'responsible user manages unit events', js: true do
  include_context 'company with users'
  let!(:unit) { create(:unit, company: company, responsible_user: staff_member) }
  let(:create_params) { attributes_for(:event) }
  let(:update_params) { attributes_for(:event) }

  before do
    login_as staff_member
    visit company_unit_path(unit)
  end

  xscenario 'adds, updates and deletes an event' do
    expect(page).to have_text('Planed events')

    expect(page).not_to have_text(create_params[:title])
    within '#fullcalendar' do
      find('td.fc-widget-content', match: :first).click
      wait_for_ajax
    end

    fill_in id: :event_title, with: create_params[:title]
    click_on 'Add event'
    wait_for_ajax

    expect(page).to have_text('Event added successfully', wait: 5)
    expect(page).to have_text(create_params[:title])

    within '#fullcalendar' do
      find('span', text: create_params[:title], match: :first).click
      wait_for_ajax
    end

    click_on 'Update'
    fill_in id: :event_title, with: update_params[:title]
    click_on 'Update event'
    wait_for_ajax

    expect(page).to have_text('Event updated successfully', wait: 5)
    expect(page).not_to have_text(create_params[:title])
    expect(page).to have_text(update_params[:title])

    within '#fullcalendar' do
      find('span', text: update_params[:title]).click
      wait_for_ajax
    end

    within '#small-dialog' do
      accept_confirm do
        find('a[data-method="delete"]').click
      end
    end
    wait_for_ajax

    expect(page).to have_text('Event removed successfully', wait: 5)
    expect(page).not_to have_text(update_params[:title])
  end
end
