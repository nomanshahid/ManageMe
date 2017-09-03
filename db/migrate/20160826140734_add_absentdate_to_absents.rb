class AddAbsentdateToAbsents < ActiveRecord::Migration
  def change
    add_column :absents, :absent_date, :date
  end
end
