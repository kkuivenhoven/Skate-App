#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://www.railstutorial.org/book/modeling_users

class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
  end
end
