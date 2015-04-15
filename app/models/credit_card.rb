class CreditCard < ActiveRecord::Base
	has_many :receipts
  belongs_to :user
  validates :name, :number, :month, :year, :cvv, :cc_type, presence: true
end
