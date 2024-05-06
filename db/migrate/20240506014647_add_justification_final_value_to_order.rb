class AddJustificationFinalValueToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :justification_final_value, :text
  end
end
