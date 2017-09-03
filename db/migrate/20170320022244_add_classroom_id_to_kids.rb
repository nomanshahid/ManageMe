class AddClassroomIdToKids < ActiveRecord::Migration
  def change
  	add_column :kids, :classroom_id, :integer
  end
end
