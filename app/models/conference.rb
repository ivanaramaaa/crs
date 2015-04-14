class Conference < ActiveRecord::Base
  has_many :conference_registrations
  has_many :users, through: :conference_registrations

  validates :name, :start_date, :end_date, :fee, presence: true
end
