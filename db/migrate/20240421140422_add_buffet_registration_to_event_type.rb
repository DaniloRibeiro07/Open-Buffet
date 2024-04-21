class AddBuffetRegistrationToEventType < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_types, :buffet_registration, null: false, foreign_key: true
  end
end
