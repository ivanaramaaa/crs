class RemoveReceiptIdFromConferenceRegistrations < ActiveRecord::Migration
  def change
    remove_reference :conference_registrations, :receipt, index: true
    remove_foreign_key :conference_registrations, :receipts
  end
end
