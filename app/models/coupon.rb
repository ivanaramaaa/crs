class Coupon < ActiveRecord::Base
	validates :name, :code, :discount, :conference_id, presence: true

  validates_uniqueness_of :code, scope: :conference_id, case_sensitive: false

  validates_numericality_of :discount, less_than_or_equal_to: 1.0
  
  belongs_to :conference
end
