class AddSeedToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :seed, :boolean
  end
end
