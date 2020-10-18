require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'login followed by logout', type: :feature do
  let(:user) { User.create(name: 'Morris') }

  scenario 'login page' do
    visit root_path
    fill_in 'session_name', with: user.name
    click_button 'Login'
    sleep(3)
    expect(page).to have_content('My Events')
    click_on 'Log out', match: :first
    sleep(3)
    expect(page).to have_content('Login')
  end
end

RSpec.describe 'Log in fields', type: :feature do
  describe 'fields in login page' do
    it 'name field in login page' do
      visit login_path
      expect(page).to have_content 'Name'
    end
  end
end
