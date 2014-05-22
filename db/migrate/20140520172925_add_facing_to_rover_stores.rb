class AddFacingToRoverStores < ActiveRecord::Migration
  def change
    add_column :rover_stores, :facing, :string, default: 'north'
  end
end
