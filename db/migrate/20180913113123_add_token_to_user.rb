class AddTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string, array: true, default: [], index: true
  end
end
