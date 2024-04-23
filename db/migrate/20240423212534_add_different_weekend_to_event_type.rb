class AddDifferentWeekendToEventType < ActiveRecord::Migration[7.1]
  def change
    add_column :event_types, :different_weekend, :boolean
  end
end
