#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://www.railstutorial.org/book/modeling_users

class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
