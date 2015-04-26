class CreditCard < ActiveRecord::Base
  belongs_to :user

  validates :name, :number, :month, :year, :cvv, :cc_type, :user_id, presence: true
  
  validates :number, length: { is: 16 }

  validates_inclusion_of :month, :in => ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"], message: "- Please enter the month in MM form (ex. 10 for October)."

  validates :year, length: { is: 4 }

  validates :cvv, length: { is: 3 }

  validates_inclusion_of :cc_type, :in => ["Visa","MasterCard","American Express", "Discover"], message: "- Please enter Visa, MasterCard, American Express, or Discover."

  validates_uniqueness_of :number, scope: :user_id
end
