class RemoveColumnsFromKids < ActiveRecord::Migration
  def change
  	remove_column :kids, :discharged, :boolean
  	remove_column :kids, :drop_time, :time
  	remove_column :kids, :pick_time, :time
  end
end
