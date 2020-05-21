require 'rails_helper'

RSpec.describe EmailValidator do
  with_model :user_card do
    table do |t|
      t.string :email
    end

    model do
      validates :email, email: true
    end
  end

  it 'Valid with correct email' do
    expect(UserCard.new(email: 'paw.user@gmail.com')).to be_valid
  end

  it 'Invalid with not correct email' do
    expect(UserCard.new(email: 'hello-world.com')).not_to be_valid
  end
end
