class ConferenceRegistration < ActiveRecord::Base
  validates :user_id, :conference_id, :diet, :name, :email, presence: true

  validates_uniqueness_of :user_id, :scope => [:conference_id, :paper_id], message: " cannot register the same paper for the same conference twice."

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  belongs_to :user
  belongs_to :conference
end
