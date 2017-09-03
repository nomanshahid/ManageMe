class AddColumnClassNameToKids < ActiveRecord::Migration
  def change
  	add_column :kids, :class_name, :string
  end
end
