class MakeMoreChangesToKids < ActiveRecord::Migration
  def change
  	add_column :kids, :food_description_four, :string
  	add_column :kids, :food_medication_four, :string
  	add_column :kids, :food_symptoms_four, :string
  	add_column :kids, :food_expiry_four, :date
  	add_column :kids, :food_actions_four, :text
  	add_column :kids, :food_epipen_four, :boolean
  	add_column :kids, :food_private_four, :boolean
  end
end
