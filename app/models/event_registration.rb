class EventRegistration < ActiveRecord::Base
  validates :user_id, :event_id, presence: true
  
  # validates_uniqueness_of :user_id, scope: :event_id, message: " cannot be registered for the same event twice."
  
  belongs_to :user
  belongs_to :event
end
