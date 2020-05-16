require 'rails_helper'

feature 'responsible user manages unit recurring events', js: true do
  include_context 'company with users'
  let!(:unit) { create(:unit, company: company, responsible_user: staff_member) }
  let(:create_params) { attributes_for(:recurring_event) }
  let(:update_params) { attributes_for(:recurring_event) }

  before do
    login_as staff_member
    visit company_unit_path(unit)
  end

  scenario 'adds, updates and deletes an event' do
    expect(page).to have_text('Planed events')

    expect(page).not_to have_text(create_params[:title])
    within '#fullcalendar' do
      find('td.fc-widget-content' \
           "[data-date=\"#{1.day.from_now.strftime('%Y-%m-%d')}\"]").click
      wait_for_ajax
    end
    find('#addRecurringEvent').click
    wait_for_ajax
    fill_in id: :recurring_event_title, with: create_params[:title]
    click_on 'Add recurring event'
    wait_for_ajax

    expect(page).to have_text('Event added successfully')
    expect(page).to have_text(create_params[:title], minimum: 2)

    within '#fullcalendar' do
      first('span', text: create_params[:title]).click
      wait_for_ajax
    end

    click_on 'Update'
    fill_in id: :recurring_event_title, with: update_params[:title]
    click_on 'Update recurring event'
    wait_for_ajax

    expect(page).to have_text('Event updated successfully')
    expect(page).not_to have_text(create_params[:title])
    expect(page).to have_text(update_params[:title], minimum: 2)

    within '#fullcalendar' do
      first('span', text: update_params[:title]).click
      wait_for_ajax
    end

    within '#small-dialog' do
      accept_confirm do
        find('a[data-method="delete"]').click
      end
    end
    wait_for_ajax

    expect(page).to have_text('Event removed successfully')
    expect(page).not_to have_text(update_params[:title])
  end
end
