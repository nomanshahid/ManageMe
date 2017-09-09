class RemoveAllergiesCountFromAllergies < ActiveRecord::Migration
  def change
    remove_column :allergies, :allergies_count, :integer
  end
end
