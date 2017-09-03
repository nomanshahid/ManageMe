class AddColumnsToClassrooms < ActiveRecord::Migration
  def change
  	add_column :classrooms, :start_range, :integer
  	add_column :classrooms, :end_range, :integer
  end
end
