#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://www.railstutorial.org/book/modeling_users

class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activated_at, :datetime
  end
end
