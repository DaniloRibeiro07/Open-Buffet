class ChangeColumnNameDescriptionToComplementInCustomerAddresses < ActiveRecord::Migration[7.1]
  def change
    change_column :customer_addresses, :description, :complement
  end
end
