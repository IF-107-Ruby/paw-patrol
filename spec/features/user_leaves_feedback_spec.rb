require 'rails_helper'

feature 'User leaves feedback' do
  let(:feedback) { create(:feedback) }

  scenario 'successfully sent feedback' do
    visit '/contact'

    expect(page).to have_css('h2', text: 'Contact')
    fill_in 'name', with: feedback.user_full_name
    fill_in 'email', with: feedback.email
    fill_in 'comments', with: feedback.message

    click_on 'Send Feedback'

    expect(page).to have_css('.notification.success.closeable', text: 'Feedback sent')
  end

  scenario 'unsuccessfully sent not valid feedback' do
    visit '/contact'

    click_on 'Send Feedback'

    expect(page).to have_css('.notification.warning.closeable',
                             text: 'Feedback is not sent!')
    expect(page).to have_css('#error_explanation')
  end
end
