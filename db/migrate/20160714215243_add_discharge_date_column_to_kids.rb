class AddDischargeDateColumnToKids < ActiveRecord::Migration
  def change
    add_column :kids, :discharge_date, :date
  end
end
