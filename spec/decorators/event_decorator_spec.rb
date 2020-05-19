require 'rails_helper'

RSpec.describe EventDecorator do
  let(:one_time_event) { create(:event).decorate }
  let(:recurring_event) { create(:event, :weekly).decorate }

  context 'one time event' do
    it 'duration_in_words' do
      timespan_text = "From #{one_time_event.anchor.to_formatted_s(:short)} " \
                      "to #{(one_time_event.anchor + one_time_event.duration.minutes)
                      .to_formatted_s(:short)}"
      expect(one_time_event.duration_in_words)
        .to(eq(timespan_text))
    end
  end

  context 'recurring event' do
    it 'duration_in_words' do
      duration_in_words = 'Duration: ' + helper.distance_of_time_in_words(
        recurring_event.anchor, recurring_event.anchor +
      recurring_event.duration.minutes
      )
      expect(recurring_event.duration_in_words)
        .to(eq(duration_in_words))
    end
  end
end
