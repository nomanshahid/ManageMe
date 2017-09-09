class RemoveColumnDateFromAbsents < ActiveRecord::Migration
  def change
    remove_column :absents, :date, :date
  end
end
