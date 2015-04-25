class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.decimal :fee
      t.references :conference, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :conferences
  end
end
