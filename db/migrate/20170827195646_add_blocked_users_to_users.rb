class AddBlockedUsersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blocked_users, :string, array: true, default: []
  end
end
