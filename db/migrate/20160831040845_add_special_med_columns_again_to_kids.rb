class AddSpecialMedColumnsAgainToKids < ActiveRecord::Migration
  def change
  	remove_column :kids, :special_med_description_five, :string
  	remove_column :kids, :special_med_medication_five, :string
  	remove_column :kids, :special_med_symptoms_five, :string
  	remove_column :kids, :special_med_expiry_five, :date
  	remove_column :kids, :special_med_actions_five, :text
  	remove_column :kids, :special_med_epipen_five, :boolean
  	add_column :kids, :special_med_description_one, :string
  	add_column :kids, :special_med_medication_one, :string
  	add_column :kids, :special_med_symptoms_one, :string
  	add_column :kids, :special_med_expiry_one, :date
  	add_column :kids, :special_med_actions_one, :text
  	add_column :kids, :special_med_epipen_one, :boolean
  end
end
