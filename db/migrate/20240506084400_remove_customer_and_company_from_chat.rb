class RemoveCustomerAndCompanyFromChat < ActiveRecord::Migration[7.1]
  def change
    remove_reference :chats, :customer, null: false, foreign_key: {to_table: :users}
    remove_reference :chats, :company, null: false, foreign_key: {to_table: :users}
  end
end
