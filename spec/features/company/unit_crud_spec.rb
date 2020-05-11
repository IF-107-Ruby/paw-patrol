require 'rails_helper'

feature 'unit crud' do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, :with_children, company: company) }
  let(:child) { unit.children.first }
  let(:unit_params) { attributes_for(:unit) }

  before { login_as company_owner }

  scenario 'successfully browses company units', js: true do
    unit_with_children = create(:unit, :with_children, company: company)

    visit company_units_path
    expect(page).to have_text("#{company.name}'s units")
    expect(page).to have_text('Company units')

    expect(page).not_to have_text(unit_with_children.children.first.name)
    find_link(href: company_unit_children_path(unit_with_children.id)).click
    wait_for_ajax
    expect(page).to have_text(unit_with_children.children.first.name)
  end

  scenario 'successfully creates a unit' do
    visit new_company_unit_path

    fill_in id: 'unit_name', with: unit_params[:name]

    find('button', class: 'button ripple-effect button-sliding-icon big').click

    expect(page).to have_text('Unit created successfully.')
    expect(page).to have_content(unit_params[:name])
  end

  scenario 'successfully updates a unit' do
    visit company_unit_path(unit)

    find_link(href: edit_company_unit_path(unit)).click

    expect(page).to have_text("Update #{unit.name}")

    fill_in id: 'unit_name', with: unit_params[:name]
    find('button', class: 'button ripple-effect button-sliding-icon big').click

    expect(page).to have_text('Unit updated successfully.')
    expect(page).to have_content(unit_params[:name])
  end

  scenario 'successfully deletes a unit', js: true do
    visit company_unit_path(unit)

    expect(page).to have_content(child.name)

    find("li[data-unit-id=\"#{child.id}\"]").hover
    within('.buttons-to-right') do
      accept_confirm do
        find('a[data-method="delete"]').click
      end
    end
    wait_for_ajax
    expect(page).not_to have_content(child.name)
  end
end
