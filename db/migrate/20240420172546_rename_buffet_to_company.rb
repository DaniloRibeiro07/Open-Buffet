class RenameBuffetToCompany < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :buffet, :company
  end
end
