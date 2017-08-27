class AddHiddenUsersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hidden_users, :string, array: true, default: []
  end
end
