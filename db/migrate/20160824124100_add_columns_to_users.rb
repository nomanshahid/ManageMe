class AddColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :days_absence_threshold, :integer
  	add_column :users, :infant_ff_rate_day, :string
  	add_column :users, :toddler_ff_rate_day, :string
  	add_column :users, :preschool_ff_rate_day, :string
  	add_column :users, :schoolage_ff_rate_day, :string
  end
end
