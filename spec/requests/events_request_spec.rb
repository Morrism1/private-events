require 'rails_helper'
require 'capybara/rspec'
# rubocop:disable  Layout/LineLength
RSpec.describe EventsController, type: :controller do
  context 'GET events controller views' do
    before(:each) do
      @user = User.new(id: '1', name: 'Morris').save
      @event = Event.new(id: '1', title: 'Javascript', description: 'Best programming language in Universe', location: 'New York', date: '2022-04-14', creator_id: '1').save
    end
    it 'GET #index' do
      get :index
      expect(response).to be_successful
    end
    it 'GET #show' do
      get :show, params: { id: '1' }
      expect(response).to be_successful
    end
  end
  context 'Create an event' do
    it 'should create a new event' do
      @user = User.new(id: '1', name: 'Morris').save
      @event = Event.new(id: '1', title: 'Javascript', description: 'Best programming language in Universe', location: 'New York', date: '2022-04-14', creator_id: '1')
      expect(@event.save).to eq(true)
    end
  end
  context 'Attend an event' do
    it 'should create an attendance for an event' do
      @user = User.new(id: '1', name: 'Morris').save
      @event = Event.new(id: '1', title: 'Javascript', description: 'Best programming language in Universe', location: 'New York', date: '2022-04-14', creator_id: '1').save
      @attend = EventAttendee.new(attendee_id: '1', attended_event_id: '1')
      expect(@attend.save).to eq(true)
    end
  end
end

RSpec.describe 'Event Management', type: :feature do
  let(:user) { User.create(id: '1', name: 'Morris') }
  let(:event) { Event.create(id: '1', title: 'Javascript', description: 'Best programming language in Universe', location: 'New York', date: '2022-04-14', creator_id: '1') }
  before(:each) do
    visit root_path
    fill_in 'session_name', with: user.name
    click_button 'Login'
  end

  scenario 'create event' do
    visit new_event_path
    fill_in 'event_title', with: 'Elixir'
    fill_in 'event_description', with: 'Next cool language to Ruby'
    fill_in 'event_location', with: 'Lagos'
    fill_in 'event_date',	with: '2022-04-12'
    click_button 'Create Event'
    sleep(3)
    expect(page).to have_content('Elixir')
  end

  scenario 'attend event' do
    visit event_path(event)
    click_button 'Attend'
    sleep(3)
    expect(page).to have_content('Past Hosted Events')
  end

  scenario 'Get new page' do
    visit new_event_path
    expect(page).to have_content('Create Event')
  end
end

RSpec.describe 'Create event fields', type: :feature do
  let(:user) { User.create(id: '1', name: 'Morris') }
  let(:event) { Event.create(id: '1', title: 'Javascript', description: 'Best programming language in Universe', location: 'New York', date: '2022-04-14', creator_id: '1') }
  before(:each) do
    visit root_path
    fill_in 'session_name', with: user.name
    click_button 'Login'
  end

  describe 'fields in Create event page' do
    it 'title field in Create event page' do
      visit new_event_path
      expect(page).to have_content 'Title'
    end
    it 'Description field in Create event page' do
      visit new_event_path
      expect(page).to have_content 'Description'
    end
    it 'Location field in Create event page' do
      visit new_event_path
      expect(page).to have_content 'Location'
    end
    it 'Date field in Create event page' do
      visit new_event_path
      expect(page).to have_content 'Date'
    end
  end
end
# rubocop:enable  Layout/LineLength
