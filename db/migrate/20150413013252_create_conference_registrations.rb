class CreateConferenceRegistrations < ActiveRecord::Migration
  def change
    create_table :conference_registrations do |t|
      t.references :user, index: true
      t.references :conference, index: true
      t.references :receipt, index: true
      t.string :diet

      t.timestamps null: false
    end
    add_foreign_key :conference_registrations, :users
    add_foreign_key :conference_registrations, :conferences
    add_foreign_key :conference_registrations, :receipts
  end
end
