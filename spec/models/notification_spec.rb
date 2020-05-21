require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employees_and_tickets, company: company) }
  let!(:ticket) { unit.tickets.first }
  let!(:employee) { ticket.user }
  let!(:comment) do
    create(:comment, :with_notification, commentable: ticket, user: employee)
  end
  let!(:notification) { comment.notification }

  describe 'Associations' do
    it { is_expected.to have_db_column(:noticeable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:noticeable_type).of_type(:string) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:notified_by) }
    it { is_expected.to belong_to(:noticeable) }
  end

  describe 'Validations' do
    context 'Presence validation' do
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:notified_by) }
      it { is_expected.to validate_presence_of(:noticeable) }
    end
  end
end
