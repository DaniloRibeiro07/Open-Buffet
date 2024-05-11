class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.references :customer, null: false, foreign_key: {to_table: :users}
      t.references :company, null: false, foreign_key: {to_table: :users}
      t.boolean    :to_company
      t.timestamps
    end
  end
end
