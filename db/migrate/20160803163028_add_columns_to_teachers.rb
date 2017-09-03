class AddColumnsToTeachers < ActiveRecord::Migration
  def change
  	add_column :teachers, :phone, :string
  	add_column :teachers, :alt_phone, :string
  	add_column :teachers, :title, :string
  end
end
