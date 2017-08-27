class AddRecipientIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :recipient_id, :integer
  end
end
