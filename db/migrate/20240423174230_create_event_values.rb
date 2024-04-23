class CreateEventValues < ActiveRecord::Migration[7.1]
  def change
    create_table :event_values do |t|
      t.float :base_price
      t.float :price_per_person

      t.timestamps
    end
  end
end
