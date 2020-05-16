require 'rails_helper'

RSpec.describe RecurringEventDecorator do
  let(:recurring_event) { create(:recurring_event).decorate }

  it 'duration_in_words' do
    duration_in_words = 'Duration: ' + helper.distance_of_time_in_words(
      recurring_event.anchor, recurring_event.anchor +
      recurring_event.duration.minutes
    )
    expect(recurring_event.duration_in_words)
      .to(eq(duration_in_words))
  end
end
