class AddFirebaseUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firebase_uid, :string
  end
end
