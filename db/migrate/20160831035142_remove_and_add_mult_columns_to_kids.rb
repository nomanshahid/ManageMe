class RemoveAndAddMultColumnsToKids < ActiveRecord::Migration
  def change
  	remove_column :kids, :allergy_private_one, :boolean
  	remove_column :kids, :allergy_private_two, :boolean
  	remove_column :kids, :allergy_private_three, :boolean
  	remove_column :kids, :food_private_one, :boolean
  	remove_column :kids, :food_private_two, :boolean
  	remove_column :kids, :food_private_three, :boolean
  	remove_column :kids, :food_private_four, :boolean
  	add_column :kids, :allergy_description_four, :string
  	add_column :kids, :allergy_medication_four, :string
  	add_column :kids, :allergy_symptoms_four, :string
  	add_column :kids, :allergy_expiry_four, :date
  	add_column :kids, :allergy_actions_four, :text
  	add_column :kids, :allergy_epipen_four, :boolean
  	add_column :kids, :allergy_description_five, :string
  	add_column :kids, :allergy_medication_five, :string
  	add_column :kids, :allergy_symptoms_five, :string
  	add_column :kids, :allergy_expiry_five, :date
  	add_column :kids, :allergy_actions_five, :text
  	add_column :kids, :allergy_epipen_five, :boolean
  	add_column :kids, :food_description_five, :string
  	add_column :kids, :food_medication_five, :string
  	add_column :kids, :food_symptoms_five, :string
  	add_column :kids, :food_expiry_five, :date
  	add_column :kids, :food_actions_five, :text
  	add_column :kids, :food_epipen_five, :boolean
  	add_column :kids, :special_med_description_five, :string
  	add_column :kids, :special_med_medication_five, :string
  	add_column :kids, :special_med_symptoms_five, :string
  	add_column :kids, :special_med_expiry_five, :date
  	add_column :kids, :special_med_actions_five, :text
  	add_column :kids, :special_med_epipen_five, :boolean

  end
end


