class ChangeXAndYDefaultToRoverStores < ActiveRecord::Migration
  def change
    change_column_default :rover_stores, :x, 0
    change_column_default :rover_stores, :y, 0
  end
end
