class AddAllergiesCountToKids < ActiveRecord::Migration
  def change
    add_column :kids, :allergies_count, :integer, default: 0
  end
end
