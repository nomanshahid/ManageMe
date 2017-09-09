class AddBaToKids < ActiveRecord::Migration
  def change
    add_column :kids, :ba, :boolean
  end
end
