class ChangeColumnNameDescriptionToComplementInCustomerAddresseas < ActiveRecord::Migration[7.1]
  def change
    remove_columns :customer_addresses, :description
  end
end
