class AlterColumnCreditCardsNumber < ActiveRecord::Migration
  def change
  	change_column :credit_cards, :number, :string
  end
end
