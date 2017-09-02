class AddBlockedByToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blocked_by, :text
  end
end
