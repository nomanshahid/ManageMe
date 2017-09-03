class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :class_name
      t.string :class_desc
      t.integer :capacity
      t.integer :num_teachers
      t.integer :num_students
      t.string :status

      t.timestamps null: false
    end
  end
end
