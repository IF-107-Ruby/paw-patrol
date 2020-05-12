require 'rails_helper'

RSpec.describe TicketMailer, type: :mailer do
  describe 'ivivation email' do
    let!(:company) { create(:company) }
    let!(:responsible_user) { create(:staff_member, :with_company, company: company) }
    let!(:unit) do
      create(:unit, :with_employee_and_ticket, company: company,
                                               responsible_user_id: responsible_user.id)
    end
    let!(:employee) { unit.users.first }
    let!(:ticket) { create(:ticket, unit: unit, user: employee) }
    let!(:mail) { described_class.new_ticket_email(ticket) }

    it 'renders the subject' do
      expect(mail.subject).to eql('New ticket')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([unit.responsible_user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['roompassport@example.com'])
    end

    it 'assigns ticket name' do
      expect(mail.body.encoded).to match(ticket.name)
    end

    it 'assigns unit name' do
      expect(mail.body.encoded).to match(ticket.unit.name)
    end
  end
end
