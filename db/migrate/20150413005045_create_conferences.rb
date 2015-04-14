class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.decimal :fee

      t.timestamps null: false
    end
  end
end
