class CreateCustomerAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_addresses do |t|
      t.string :public_place
      t.string :neighborhood
      t.string :state
      t.string :city
      t.string :zip
      t.string :description

      t.timestamps
    end
  end
end
