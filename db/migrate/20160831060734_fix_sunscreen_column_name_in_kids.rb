class FixSunscreenColumnNameInKids < ActiveRecord::Migration
  def change
  	rename_column :kids, :suncreen, :sunscreen
  end
end
