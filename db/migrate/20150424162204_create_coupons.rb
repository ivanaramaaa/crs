class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.decimal :discount
      t.references :conference, index: true

      t.timestamps null: false
    end
    add_foreign_key :coupons, :conferences
  end
end
