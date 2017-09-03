class RemoveYearColumnFromAbsents < ActiveRecord::Migration
  def change
    remove_column :absents, :year, :integer
  end
end
