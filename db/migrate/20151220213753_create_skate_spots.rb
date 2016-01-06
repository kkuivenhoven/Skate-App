class CreateSkateSpots < ActiveRecord::Migration
  def change
    create_table :skate_spots do |t|

      t.timestamps null: false
    end
  end
end
