class AddMessageToChat < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :message, :text
  end
end
