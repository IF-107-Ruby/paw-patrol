# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  body             :text             not null
#  user_id          :bigint           not null
#  ancestry         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employees_and_tickets, company: company) }
  let!(:ticket) { unit.tickets.first }
  let!(:comment) { create(:comment, commentable: ticket) }

  describe 'Associations' do
    it { is_expected.to have_db_column(:commentable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:commentable_type).of_type(:string) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:commentable) }
    it 'assign ticket as commentable' do
      expect(comment.commentable_type).to eq('Ticket')
      expect(comment.commentable_id).to eq(ticket.id)
    end
  end

  describe 'Validations' do
    context 'Presence validation' do
      it { expect(comment).to be_valid }
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_presence_of(:commentable) }
    end
  end
end
