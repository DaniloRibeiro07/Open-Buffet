class ChangeTypeAddressNumberInCustomerAddress < ActiveRecord::Migration[7.1]
  def change
    change_column :customer_addresses, :address_number, :string
  end
end
