class Receipt < ActiveRecord::Base
  belongs_to :credit_card
end
