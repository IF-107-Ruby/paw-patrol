require 'rails_helper'

feature 'EmployeeAddComment' do
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

  scenario 'ticket author successfully see comments and add new one', js: true do
    login_as employee
    visit company_ticket_path(ticket)

    expect(page).to have_text('Comments')
    find('#add-comment').click

    using_wait_time 2 do
      within '#new-comment' do
        fill_in id: 'comment_body', with: 'Test comment from employee'
      end
    end

    click_on 'Send'
    wait_for_ajax

    expect(page).to have_text('Comment has been saved')
    expect(page).to have_text('Test comment from employee')

    fill_in id: 'comment_body', with: ''
    click_on 'Send'
    wait_for_ajax
    expect(page).to have_text('Comment failed to save, please try again')
  end

  scenario 'resposible for unit see comments and add new one', js: true do
    login_as responsible_user
    visit company_ticket_path(ticket)

    expect(page).to have_text('Comments')

    find('#add-comment').click
    using_wait_time 2 do
      within '#new-comment' do
        fill_in id: 'comment_body', with: 'Test comment from responsible user'
      end
    end
    click_on 'Send'
    wait_for_ajax

    expect(page).to have_text('Test comment from responsible user')
  end

  scenario 'another employee can not see comments' do
    login_as another_employee
    visit company_ticket_path(ticket)

    expect(page).not_to have_text('Comments')
  end
end