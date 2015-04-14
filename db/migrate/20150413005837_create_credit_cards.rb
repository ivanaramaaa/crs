class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.integer :number
      t.string :month
      t.integer :year
      t.integer :cvv
      t.string :type
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :credit_cards, :users
  end
end
