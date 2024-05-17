class AddStatusToBuffetRegistration < ActiveRecord::Migration[7.1]
  def change
    add_column :buffet_registrations, :available, :integer, :default => 1
  end
end
