require 'rails_helper'

RSpec.describe TicketMailer, type: :mailer do
  let!(:company) { create(:company) }

  describe 'inform responsible user about new ticket' do
    let(:unit_with_responsible_user) do
      create(:unit, :with_responsible_user, :with_employee_and_ticket, company: company)
    end
    let(:responsible_user) { unit_with_responsible_user.responsible_user }
    let!(:employee) { unit_with_responsible_user.users.last }
    let!(:ticket) { create(:ticket, unit: unit_with_responsible_user, user: employee) }
    let!(:mail) { described_class.new_ticket_email(ticket) }

    it 'renders the subject' do
      expect(mail.subject).to eql('New ticket created')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([unit_with_responsible_user.responsible_user.email])
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

  describe 'inform company owner about new ticket' do
    let!(:company_owner) { create(:company_owner, company: company) }
    let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
    let!(:employee) { unit.users.last }
    let!(:ticket) { create(:ticket, unit: unit, user: employee) }
    let!(:mail) { described_class.assign_responsible_user_email(ticket) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Assign responsible user')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([company_owner.email])
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

  describe 'ticket_resolved_email' do
    let!(:unit) do
      create(:unit,
             :with_employee_and_ticket,
             :with_responsible_user,
             company: company)
    end
    let!(:ticket) { unit.tickets.first }
    let!(:comment) do
      create(:comment, commentable: ticket, user: unit.responsible_user)
    end
    let!(:mail) { described_class.ticket_resolved_email(ticket) }

    it 'renders the subject' do
      expect(mail.subject).to eql("Ticket: #{ticket.name}")
    end

    it 'renders the receivers email' do
      expect(mail.to).to eql([ticket.user.email, unit.responsible_user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['roompassport@example.com'])
    end

    it 'assigns ticket name' do
      expect(mail.body.encoded).to match(ticket.name)
    end
  end
end
