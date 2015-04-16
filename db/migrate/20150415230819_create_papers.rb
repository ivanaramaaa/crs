class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
    	t.string :title
    	t.string :authors
    	t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :papers, :users
    add_attachment :papers, :attachment
  end
end
