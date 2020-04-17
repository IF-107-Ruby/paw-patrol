require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { FactoryBot.create(:unit, :with_children, name: 'Parent unit') }

  describe 'Validation tests' do
    it 'is valid with valid attributes' do
      expect(unit).to be_valid
    end

    it 'is not valid without unit name' do
      unit.name = nil
      expect(unit).to_not be_valid
    end

    it 'is valid without qr_link' do
      unit.qr_link = nil
      expect(unit).to be_valid
    end
  end

  describe 'Unit tree structure' do
    let(:unit_child_1) { FactoryBot.create(:unit, :with_parent, name: 'Unit Child 1') }
    let(:unit_child_2) { FactoryBot.create(:unit, :with_parent, name: 'Unit Child 2') }

    it 'should have children' do
      unit.children.create(name: 'Child 2')
      expect(unit.ancestry).to be_nil
      expect(unit.children).to_not be_empty
      expect(unit.children.first.name).to eq('Child 1')
      expect(unit.children.second.name).to eq('Child 2')
    end

    it 'should have parent' do
      unit_child_1.parent = unit
      unit_child_2.parent = unit
      expect(unit_child_1.parent).to_not be_nil
      expect(unit_child_1.ancestry).to eq(unit.id.to_s)
      expect(unit_child_2.ancestry).to eq(unit.id.to_s)
    end
  end
end
