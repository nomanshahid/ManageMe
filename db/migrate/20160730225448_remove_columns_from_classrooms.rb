class RemoveColumnsFromClassrooms < ActiveRecord::Migration
  def change
  	remove_column :classrooms, :num_students, :integer
  	remove_column :classrooms, :num_teachers, :integer
  	remove_column :classrooms, :status, :string
  end
end
