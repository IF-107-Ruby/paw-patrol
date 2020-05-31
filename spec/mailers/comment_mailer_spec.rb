require 'rails_helper'

RSpec.describe CommentMailer, type: :mailer do
  describe 'inform watchers about new comment' do
    let!(:company) { create(:company) }
    let!(:unit) { create(:unit, :with_employees, company: company) }
    let!(:employee) { unit.employees.first }
    let!(:watchers) { unit.employees }
    let!(:ticket) { create(:ticket, user: employee, unit: unit, watchers: watchers) }
    let!(:comment) { create(:comment, commentable: ticket, user: employee) }
    let!(:mail) { described_class.new_comment_email(comment, ticket) }

    it 'renders the subject' do
      expect(mail.subject).to eql('New comment added')
    end

    it 'renders the receiver email' do
      expect(mail.bcc.size).to eql(ticket.watchers.size)
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['roompassport@example.com'])
    end

    it 'assigns ticket name' do
      expect(mail.body.encoded).to match(ticket.name)
    end
  end
end
