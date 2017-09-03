class MakeAnotherChangeToKids < ActiveRecord::Migration
  def change
  	remove_column :kids, :email_corr, :boolean
  	add_column :kids, :gaurdian_one_email_corr, :boolean
  	add_column :kids, :gaurdian_two_email_corr, :boolean
  end
end
