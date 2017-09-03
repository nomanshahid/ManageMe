class AddAllergiesCountToAllergies < ActiveRecord::Migration
  def change
    add_column :allergies, :allergies_count, :integer, default: 0
  end
end
