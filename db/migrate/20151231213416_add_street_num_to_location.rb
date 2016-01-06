class AddStreetNumToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :street_num, :integer
  end
end
