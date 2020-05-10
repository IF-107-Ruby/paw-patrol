require 'rails_helper'

RSpec.describe UnitDecorator do
  let(:company) { create(:company) }
  let(:unit_without_parent) { create(:unit, company: company).decorate }
  let(:unit_with_parent) { create(:unit, :with_parent, company: company).decorate }
  let(:unit_with_responsible_user) do
    create(:unit, :with_responsible_user, company: company).decorate
  end
  let(:responsible_user) { unit_with_responsible_user.responsible_user }

  it 'creation headline' do
    expect(unit_without_parent.creation_headline)
      .to(eq("Add new unit to #{company.name}"))
    expect(unit_with_parent.creation_headline)
      .to(eq("Add new sub unit to #{unit_with_parent.parent.name}"))
  end

  it 'responsible_user_text' do
    expect(unit_with_responsible_user.responsible_user_text)
      .to(eq("#{responsible_user.full_name} is responsible"))
  end
end
