require 'rails_helper'

# TODO

RSpec.describe Comment, type: :model do
  let!(:employee) { create(:employee) }
  let!(:comment) { create(:comment) }

  xdescribe 'Associations' do
    it { expect(comment).to belong_to(:user) }
    it { expect(comment).to belong_to(:ticket) }
  end

  xdescribe 'validations' do
    context 'presence validation' do
      it { expect(comment).to validate_presence_of(:user) }
      it { expect(comment).to validate_presence_of(:body) }
      it { expect(comment).to validate_presence_of(:ticket) }
    end
  end
end
