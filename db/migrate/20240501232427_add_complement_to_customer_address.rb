class AddComplementToCustomerAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_addresses, :complement, :text
  end
end
