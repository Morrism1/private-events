require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

RSpec.describe Event, type: :model do
  before do
    @user = User.create(name: 'Maurice')
  end
  context 'validation tests' do
    it "Shouldn't save if there's no date" do
      e = Event.new(creator_id: 1, description: 'Event 1', location: 'Kigali')
      expect(e.save).to eq(false)
    end
  end

  context 'validation tests' do
    it "Shouldn't save if there's no location" do
      e = Event.new(creator_id: 1, description: 'Event 1', date: '2021-01-11')
      expect(e.save).to eq(false)
    end
  end

  context 'validation tests truthy' do
    it "Should save if everything is given" do
      e = Event.new(creator_id: 1, title: 'JS', description: 'Event 1', location: 'Kigali', date: '2021-01-11')
      expect(e).to be_a_new(Event)
    end
  end

  context 'validation tests truthy' do
    it "Should save if everything is given" do
      e = Event.new(title: 'JS', description: 'Event 1', location: 'Kigali', date: '2021-01-11', creator_id: @user.id)
      expect(e).to be_valid
    end
  end

  context 'validation tests' do
    it "Shouldn't save if there's no description" do
      e = Event.new(creator_id: 1, location: 'Kigali', date: '2021-01-11')
      expect(e.save).to eq(false)
    end

    it "Shouldn't save if the description is more than 300 characters" do
      descpt = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
       In consequat auctor arcu, et blandit orci malesuada et.
       Orci varius natoque penatibus et magnis dis parturient montes,
       nascetur ridiculus mus.
       Vestibulum ante ipsum primis in faucibus orci luctus et
       ultrices posuere cubilia curae;
       Pellentesque malesuada felis nec massa rutrum varius.
       Proin in odio accumsan, pretium diam in,
       convallis tellus.'
      e = Event.new(creator_id: 1, date: '2021-04-10', description: descpt)
      expect(e.save).to eq(false)
    end
  end

  it 'has a future method' do
    expect(Event.respond_to?(:upcoming)).to be_truthy
  end

  it 'has a past method' do
    expect(Event.respond_to?(:past)).to be_truthy
  end

  context 'Association tests' do
    it { should belong_to(:creator) }
    it { should have_many(:event_attendees) }
    it { should have_many(:attendees) }
  end
end
