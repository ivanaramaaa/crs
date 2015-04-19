class AddPaperRefToConferenceRegistration < ActiveRecord::Migration
  def change
    add_reference :conference_registrations, :paper, index: true
    add_foreign_key :conference_registrations, :papers
  end
end
