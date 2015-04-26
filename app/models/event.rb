class Event < ActiveRecord::Base
	validates :name, :event_type, :fee, :conference_id, presence: true
 
  validates_uniqueness_of :name, scope: :conference_id, case_sensitive: false
  
  validates_inclusion_of :event_type, :in => ["Workshop", "Tutorial", "Special"], message: "- Please enter Workshop, Tutorial, or Special."

  belongs_to :conference
end
