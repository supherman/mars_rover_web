
class CreateRoverStores < ActiveRecord::Migration
  def change
    create_table :rover_stores do |t|
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
