class AddUserBlockedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_blocked, :text
  end
end
