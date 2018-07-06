class AddPushSubToUsers < ActiveRecord::Migration
  def change
    add_column :users, :push_sub, :string
  end
end
