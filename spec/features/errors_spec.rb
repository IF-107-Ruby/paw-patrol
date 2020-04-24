require 'rails_helper'

describe '404 page' do
  it 'is customized' do
    visit '/404'
    expect(page.status_code).to eq 404
    expect(page).to have_content('404 Not Found')
  end
end

feature 'escape from 404 page to Home page' do
  scenario 'Move to home page' do
    visit root_path
    page.should have_content('ROOM PASSPORT')
  end
end

describe '500 page' do
  it 'is customized' do
    visit '/500'
    expect(page.status_code).to eq 500
    expect(page).to have_content('Internal Server Error')
  end
end

feature 'escape from 500 page to Home page' do
  scenario 'Move to home page' do
    visit root_path
    page.should have_content('ROOM PASSPORT')
  end
end
