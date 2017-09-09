class RemoveClasssizeFromTeachers < ActiveRecord::Migration
  def change
  	remove_column :teachers, :class_size, :integer
  end
end
