class DropAllergiesTable < ActiveRecord::Migration
  def change
  	drop_table :allergies
  	remove_column :kids, :allergies_count, :boolean
  end
end
