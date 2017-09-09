class AddSchoolColumnsToKids < ActiveRecord::Migration
  def change
    add_column :kids, :school_name, :string
    add_column :kids, :school_phone, :string
  end
end
