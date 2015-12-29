class AddRatingToUser < ActiveRecord::Migration
  def change
    add_reference :users, :rating, index: true, foreign_key: true
  end
end
