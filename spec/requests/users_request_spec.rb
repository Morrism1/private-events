require 'rails_helper'
require 'capybara/rspec'

RSpec.describe UsersController, type: :controller do
  context 'GET users controller views' do
    it 'GET #index' do
      get :index
      expect(response).to be_successful
    end
    it 'GET #show' do
      @user = User.new(id: '1', name: 'Morris').save
      get :show, params: { id: '1' }
      expect(response).to be_successful
    end
    it 'GET #new/sign up page' do
      get :new
      expect(response).to be_successful
    end
  end

  context 'Create user' do
    it 'should create a user' do
      @user = User.new(id: '1', name: 'Morris')
      expect(@user.save).to eq(true)
    end
  end
end

RSpec.describe 'Sign up fields', type: :feature do
  describe 'fields in sign up page' do
    it 'name field in signup page' do
      visit signup_path
      expect(page).to have_content 'Name'
    end
  end
end

RSpec.describe 'create user and redirect to user show page', type: :feature do
  let(:user) { User.create(name: 'Morris') }

  scenario 'create user' do
    visit signup_path
    fill_in 'user_name', with: user.name
    click_button 'Create my account'
    sleep(3)
    expect(page).to have_content('My Events')
  end
end
