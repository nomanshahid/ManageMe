class AddColumnsToKids < ActiveRecord::Migration
  def change
    add_column :kids, :dob, :date
    add_column :kids, :gender, :string
    add_column :kids, :religion, :string
    add_column :kids, :admission_date, :date
    add_column :kids, :discharged, :boolean
    add_column :kids, :drop_time, :time
    add_column :kids, :pick_time, :time
    add_column :kids, :street_addr, :string
    add_column :kids, :province, :string
    add_column :kids, :postal_code, :string
    add_column :kids, :city, :string
    add_column :kids, :phone, :string
    add_column :kids, :alt_phone, :string
    add_column :kids, :student_id, :integer
    add_column :kids, :age_group, :string
    add_column :kids, :class_desc, :string
    add_column :kids, :notes, :text
    add_column :kids, :allergy, :text
  end
end
