class AddEmergColumnsToKids < ActiveRecord::Migration
  def change
    add_column :kids, :emerg_contact_one_name, :string
    add_column :kids, :emerg_contact_one_phone, :string
    add_column :kids, :emerg_contact_one_relationship, :string
    add_column :kids, :emerg_contact_two_name, :string
    add_column :kids, :emerg_contact_two_phone, :string
    add_column :kids, :emerg_contact_two_relationship, :string
    add_column :kids, :emerg_contact_three_name, :string
    add_column :kids, :emerg_contact_three_phone, :string
    add_column :kids, :emerg_contact_three_relationship, :string
    add_column :kids, :physician_name, :string
    add_column :kids, :physician_phone, :string
    add_column :kids, :physician_fax, :string
    add_column :kids, :physician_addr, :string
    add_column :kids, :physician_city, :string
    add_column :kids, :physician_postal_code, :string
    add_column :kids, :ohip, :string
    add_column :kids, :physician_notes, :string
    add_column :kids, :medications, :text
    add_column :kids, :diet_restrictions, :text
  end
end
