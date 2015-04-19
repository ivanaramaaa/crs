class AddUserDetailsToConferenceRegistration < ActiveRecord::Migration
  def change
    add_column :conference_registrations, :name, :string
    add_column :conference_registrations, :email, :string
  end
end
