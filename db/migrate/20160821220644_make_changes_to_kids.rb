class MakeChangesToKids < ActiveRecord::Migration
  def change
  	remove_column :kids, :hena_painting, :boolean
  	add_column :kids, :bus_route, :string
  	add_column :kids, :bus_driver, :string
  	add_column :kids, :special_alerts, :text
  	add_column :kids, :emerg_contact_one_work, :string
  	add_column :kids, :emerg_contact_one_cell, :string
  	add_column :kids, :emerg_contact_two_work, :string
  	add_column :kids, :emerg_contact_two_cell, :string
  	add_column :kids, :emerg_contact_three_work, :string
  	add_column :kids, :emerg_contact_three_cell, :string
  	add_column :kids, :warning_15_days_issued, :boolean
  	add_column :kids, :warning_20_consecutive_days_issued, :boolean
  	add_column :kids, :join_after_july_1st_issued, :boolean
  	add_column :kids, :warning_25_days_issued, :boolean
  	add_column :kids, :warning_33_days_issued, :boolean
  	add_column :kids, :warning_35_days_issued, :boolean
  	add_column :kids, :review_letter_issued, :boolean

  end
end
