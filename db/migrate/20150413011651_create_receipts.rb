class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.decimal :total
      t.references :credit_card, index: true

      t.timestamps null: false
    end
    add_foreign_key :receipts, :credit_cards
  end
end
