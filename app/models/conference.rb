class Conference < ActiveRecord::Base
  validates :name, :start_date, :end_date, :fee, :paper_fee, presence: true
 
  validates :name, uniqueness: true, case_sensitive: false

  has_many :conference_registrations
  has_many :events
  has_many :coupons
  end
