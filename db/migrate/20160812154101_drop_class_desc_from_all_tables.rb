class DropClassDescFromAllTables < ActiveRecord::Migration
  def change
  	remove_column :teachers, :class_desc, :string
  	remove_column :kids, :class_desc, :string
  	remove_column :kids, :age_group, :string
  	remove_column :classrooms, :class_desc, :string
  end
end
