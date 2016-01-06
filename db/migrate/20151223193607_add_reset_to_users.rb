#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://www.railstutorial.org/book/modeling_users

class AddResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
