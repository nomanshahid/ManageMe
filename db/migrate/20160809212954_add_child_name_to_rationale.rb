class AddChildNameToRationale < ActiveRecord::Migration
  def change
    add_column :rationales, :child_name, :string
  end
end
