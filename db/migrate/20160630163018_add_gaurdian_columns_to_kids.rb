class AddGaurdianColumnsToKids < ActiveRecord::Migration
  def change
    add_column :kids, :gaurdian_one_name, :string
    add_column :kids, :gaurdian_one_relationship, :string
    add_column :kids, :gaurdian_one_home_phone, :string
    add_column :kids, :gaurdian_one_mobile_phone, :string
    add_column :kids, :gaurdian_one_bus_phone, :string
    add_column :kids, :gaurdian_one_email, :string
    add_column :kids, :gaurdian_one_employer, :string
    add_column :kids, :gaurdian_one_notes, :text
    add_column :kids, :gaurdian_two_name, :string
    add_column :kids, :gaurdian_two_relationship, :string
    add_column :kids, :gaurdian_two_home_phone, :string
    add_column :kids, :gaurdian_two_mobile_phone, :string
    add_column :kids, :gaurdian_two_bus_phone, :string
    add_column :kids, :gaurdian_two_email, :string
    add_column :kids, :gaurdian_two_employer, :string
    add_column :kids, :gaurdian_two_notes, :text
  end
end
