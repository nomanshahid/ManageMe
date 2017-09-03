class AddYearToAbsents < ActiveRecord::Migration
  def change
    add_column :absents, :year, :integer
  end
end
