module ApplicationCable
  class Channel < ActionCable::Channel::Base
    private # rubocop:disable Lint/UselessAccessModifier

    delegate :company, to: :current_user, prefix: :current
  end
end
