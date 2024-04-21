class AddUserToBuffetRegistration < ActiveRecord::Migration[7.1]
  def change
    add_reference :buffet_registrations, :user, null: false, foreign_key: true
  end
end
