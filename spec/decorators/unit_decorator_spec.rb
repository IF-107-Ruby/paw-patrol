require 'rails_helper'

RSpec.describe UnitDecorator do
  let(:company) { create(:company) }
  let(:unit_without_parent) { create(:unit, company: company).decorate }
  let(:unit_with_parent) { create(:unit, :with_parent, company: company).decorate }

  it 'creation headline' do
    expect(unit_without_parent.creation_headline)
      .to(eq("Add new unit to #{company.name}"))
    expect(unit_with_parent.creation_headline)
      .to(eq("Add new unit to #{unit_with_parent.parent.name}"))
  end
end
