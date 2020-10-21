class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validates :location, presence: true
  validates :date, presence: true

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :event_attendees, foreign_key: 'attended_event_id'
  has_many :attendees, through: 'event_attendees'
  scope :upcoming, -> { where('Date >= ?', Date.today).order('Date ASC') }
  scope :past, -> { where('Date <  ?', Date.today).order('Date DESC') }
end
