require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'validate name is not empty' do
      @user = User.new.save
      expect(@user).to eq(false)
    end
    it 'should not validate if the name is shorter than 4 characters' do
      @user = User.new(name: 'abc').save
      expect(@user).to eq(false)
    end
  end

  context 'Validate model helper methods' do
    let(:user) { User.create(name: 'Kagabo') }
    let(:event) do
      Event.create(title: 'Javascript',
                   description: 'super cool language', location: 'New york',
                   date: '2022-04-12', creator_id: '1')
    end
    before(:each) do
      EventAttendee.new(attendee_id: user.id, attended_event_id: event.id).save
    end

    it 'should return 0 past events' do
      expect(user.past_events.size).to eq(0)
    end
  end
  context 'User associations tests' do
    it { should have_many(:events) }
    it { should have_many(:attended_events) }
    it { should have_many(:event_attendees) }
  end
end
