class AddOrderToChat < ActiveRecord::Migration[7.1]
  def change
    add_reference :chats, :order, foreign_key: true
  end
end
