class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :employee_id
      t.string :class_name
      t.string :class_desc
      t.integer :class_size

      t.timestamps null: false
    end
  end
end
