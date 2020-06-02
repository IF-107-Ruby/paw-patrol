require 'rails_helper'

feature 'AddCommentNotification' do
  let!(:company) { create(:company) }
  let!(:responsible_user) { create(:staff_member, :with_company, company: company) }
  let!(:unit) do
    create(:unit, :with_employees, company: company,
                                   responsible_user_id: responsible_user.id)
  end
  let!(:employee) { unit.users.first }
  let!(:another_employee) { unit.users.second }
  let!(:responsible_user) { create(:staff_member, :with_company, company: company) }
  let!(:ticket) { create(:ticket, :with_comments, user: employee, unit: unit) }
  let!(:comment) { ticket.comments.first }

  xscenario 'watchers successfully see comments notification', js: true do
    login_as responsible_user
    visit company_ticket_path(ticket)

    expect do
      within '#new-comment' do
        first('#comment_body', visible: false).set('Test comment from responsible user')
      end

      click_on 'Add comment'
      wait_for_ajax
    end.to change(Notification, :count).by(1)
  end
end
