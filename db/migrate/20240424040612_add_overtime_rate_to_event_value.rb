class AddOvertimeRateToEventValue < ActiveRecord::Migration[7.1]
  def change
    add_column :event_values, :overtime_rate, :float
  end
end
