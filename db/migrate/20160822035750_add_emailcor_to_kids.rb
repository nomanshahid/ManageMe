class AddEmailcorToKids < ActiveRecord::Migration
  def change
    add_column :kids, :email_corr, :boolean
  end
end
