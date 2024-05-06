class AddExpirationDateToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :expiration_date, :date
  end
end
