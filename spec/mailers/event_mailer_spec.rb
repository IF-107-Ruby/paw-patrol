require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  describe 'inform employees about new event' do
    let!(:company) { create(:company) }
    let!(:company_owner) { create(:company_owner, company: company) }
    let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
    let!(:employee) { unit.users.last }
    let!(:event) { create(:event, unit: unit, user: company_owner) }
    let!(:mail) { described_class.new_event_email(event) }

    it 'renders the subject' do
      expect(mail.subject).to eql('New event planned')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([employee.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['roompassport@example.com'])
    end

    it 'assigns unit name' do
      expect(mail.body.encoded).to match(event.unit.name)
    end

    it 'assigns event title' do
      expect(mail.body.encoded).to match(event.title)
    end
  end
end
