class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :events, foreign_key: 'creator_id'
  has_many :event_attendees, foreign_key: 'attendee_id'
  has_many :attended_events, through: 'event_attendees'

  def upcoming_events
    self.attended_events.upcoming
  end

  def previous_events
		self.attended_events.past
  end
  
  def attending?(event)
    event.attendees.include?(self)
  end
  
  def attend!(event)
    self.event_attendees.create!(attended_event_id: event.id)
  end
  
  def cancel!(event)
    self.event_attendees.find_by(attended_event_id: event.id).destroy
  end

end
