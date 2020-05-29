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

  scenario 'watchers successfully see comments notification',
           js: true,
           skip: true do
    login_as responsible_user
    visit company_ticket_path(ticket)

    expect do
      find('#add-comment').click
      using_wait_time 2 do
        within '#new-comment' do
          fill_in id: 'comment_body', with: 'Test comment from employee'
        end
      end

      click_on 'Send'
      wait_for_ajax
    end.to change(Notification, :count).by(1)
  end
end
