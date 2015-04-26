class Receipt < ActiveRecord::Base
	
	validates :total, :credit_card_id, :conference_registration_id, presence: true

  belongs_to :credit_card
end
