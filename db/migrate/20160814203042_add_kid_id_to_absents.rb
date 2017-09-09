class AddKidIdToAbsents < ActiveRecord::Migration
  def change
    add_column :absents, :kid_id, :integer
  end
end
