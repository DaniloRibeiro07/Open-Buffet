class AddWorkingDayPriceAndWeekendPriceRefToEventType < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_types, :working_day_price, foreign_key: {to_table: :event_values}
    add_reference :event_types, :weekend_price, foreign_key: {to_table: :event_values}
  end
end
