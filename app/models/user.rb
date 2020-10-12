class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  scope :previous_events, -> { attended_events.where('date < ?', Date.today)}
  # Ex:- scope :active, lambda {where(:active => true)}
  has_many :events, foreign_key: 'creator_id'
  has_many :event_attendees, foreign_key: 'attendee_id'
  has_many :attended_events, through: 'event_attendees'

  def upcoming_events
    self.attended_events.upcoming
  end
  
end
