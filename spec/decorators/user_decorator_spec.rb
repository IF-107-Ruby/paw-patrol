require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) { create(:user) }
  let(:decorated_user) { user.decorate }

  it 'full user name' do
    expect(decorated_user.full_name).to eq(user.first_name + ' ' + user.last_name)
  end
end
