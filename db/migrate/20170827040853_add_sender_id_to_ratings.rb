class AddSenderIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :sender_id, :integer
  end
end
