class AddRatingIdToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :rating_id, :integer
  end
end
