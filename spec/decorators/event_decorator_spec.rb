require 'rails_helper'

RSpec.describe EventDecorator do
  let(:event) { create(:event).decorate }

  it 'timespan' do
    timespan_text = "From #{event.starts_at.to_formatted_s(:short)} " \
                    "to #{event.ends_at.to_formatted_s(:short)}"
    expect(event.timespan)
      .to(eq(timespan_text))
  end
end
