class AddCalculatedValueAndFinalValueToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :calculated_value, :float
    add_column :orders, :final_value, :float
  end
end
