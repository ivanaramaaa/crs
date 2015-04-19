class AddPaperFeeToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :paper_fee, :decimal
  end
end
