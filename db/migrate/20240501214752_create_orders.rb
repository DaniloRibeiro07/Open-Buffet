class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :buffet_registration, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.date :date
      t.integer :amount_of_people
      t.boolean :inside_the_buffet
      t.references :customer_address, foreign_key: true
      t.text :observation
      t.string :code

      t.timestamps
    end
  end
end
