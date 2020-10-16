require 'rails_helper'
require 'capybara/rspec'
# rubocop:disable  Layout/LineLength
RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'validate name is not empty' do
      @user = User.new().save
      expect(@user).to eq(false)
    end
    it 'should not validate if the name is shorter than 4 characters' do
      @user = User.new(name: 'abc').save
      expect(@user).to eq(false)
    end
  end

  context 'Validate model helper methods' do
    let(:user) { User.create(name: 'Maurice') }
    let(:event) { Event.create(title: 'Javascript', description: 'super cool language', location: 'New york', date: '2022-04-12 01:00:00', creator_id: '1') }
    let(:event2) { Event.create(title: 'Elixir', description: 'Super fast language', location: 'Kigali', date: '2019-04-19 01:00:00', creator_id: '1') }
    before(:each) do
      EventAttendee.new(attendee_id: user.id, attended_event_id: event.id).save
      EventAttendee.new(attendee_id: user.id, attended_event_id: event2.id).save
    end
    it 'should return past events' do
      expect(user.past_events.size).to eq(1)
    end
    it 'should return upcoming events' do
      expect(user.upcoming_events.size).to eq(1)
    end
  end
  context 'User associations tests' do
    it { should have_many(:created_events).with_foreign_key('creator_id') }
    it { should have_many(:attendances).with_foreign_key('attendee_id') }
    it { should have_many(:attended_events).through(:attendances).source(:attended_event) }
  end
end
