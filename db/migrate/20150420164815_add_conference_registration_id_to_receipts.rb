class AddConferenceRegistrationIdToReceipts < ActiveRecord::Migration
  def change
    add_reference :receipts, :conference_registration, index: true
    add_foreign_key :receipts, :conference_registrations
  end
end
