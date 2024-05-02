class AddDurationToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :duration, :integer
  end
end
