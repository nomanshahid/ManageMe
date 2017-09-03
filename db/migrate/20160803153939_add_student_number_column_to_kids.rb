class AddStudentNumberColumnToKids < ActiveRecord::Migration
  def change
  	add_column :kids, :student_number, :integer
  	change_column :kids, :student_id, :string
  end
end
