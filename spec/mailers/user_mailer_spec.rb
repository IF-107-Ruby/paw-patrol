require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'ivivation email' do
    let!(:user) { create :company_owner, :with_company }
    let!(:mail) { described_class.invitation_email(user, user.password).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eql('Invitation email')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['roompassport@example.com'])
    end

    it 'assigns company name' do
      expect(mail.body.encoded).to match(user.company.name)
    end

    it 'assigns user name' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it 'assigns user email' do
      expect(mail.body.encoded).to match(user.email)
    end

    it 'assigns user password' do
      expect(mail.body.encoded).to match(user.password)
    end
  end
end
