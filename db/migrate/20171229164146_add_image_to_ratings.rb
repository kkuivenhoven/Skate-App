class AddImageToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :image, :string
  end
end
