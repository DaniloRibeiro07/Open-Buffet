class AddAddressNumberToCustomerAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_addresses, :address_number, :integer
  end
end
