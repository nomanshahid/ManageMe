class RemoveAltPhoneColumnFromKids < ActiveRecord::Migration
  def change
  	remove_column :kids, :alt_phone, :string
  end
end
