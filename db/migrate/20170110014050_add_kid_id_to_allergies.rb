class AddKidIdToAllergies < ActiveRecord::Migration
  def change
    add_column :allergies, :kid_id, :integer
  end
end
