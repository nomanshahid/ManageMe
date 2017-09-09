class AddClassroomIdToTeachers < ActiveRecord::Migration
  def change
  	add_column :teachers, :classroom_id, :integer
  end
end
