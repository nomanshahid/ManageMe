class AddColumnsToRationale < ActiveRecord::Migration
  def change
  	add_column :rationales, :full_name, :string
      add_column :rationales, :rational, :text
      add_column :rationales, :user_id, :integer
      add_column :rationales, :kid_id, :integer
  end
end
