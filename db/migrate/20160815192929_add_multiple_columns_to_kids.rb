class AddMultipleColumnsToKids < ActiveRecord::Migration
  def change
  	add_column :kids, :suncreen, :boolean
  	add_column :kids, :diaper_cream, :boolean
  	add_column :kids, :hand_sanitizer, :boolean
  	add_column :kids, :face_painting, :boolean
  	add_column :kids, :hena_painting, :boolean
  	add_column :kids, :vidpic_taking, :boolean

  	add_column :kids, :nuts, :boolean
  	add_column :kids, :fish, :boolean
  	add_column :kids, :eggs, :boolean
  	add_column :kids, :milk, :boolean
  	add_column :kids, :latex, :boolean
  	add_column :kids, :medication, :boolean
  	add_column :kids, :medication_text, :string
  	add_column :kids, :insect_sting, :boolean
  	add_column :kids, :insect_sting_text, :string
  	add_column :kids, :other, :boolean
  	add_column :kids, :other_text, :string
  	add_column :kids, :asthmatic, :boolean
  	add_column :kids, :asthmatic_medication, :string
  	add_column :kids, :asthmatic_medication_expiry, :date
  	add_column :kids, :emergency_action_plan, :text

  	add_column :kids, :epipen_expiry, :date
  	add_column :kids, :epipen_location, :string

  	add_column :kids, :epipen_jr_15mg, :boolean
  	add_column :kids, :epipen_30mg, :boolean
  	add_column :kids, :epipen_twinject_15mg, :boolean
  	add_column :kids, :epipen_twinject_30mg, :boolean
  	add_column :kids, :epipen_other_dosage, :boolean
  	add_column :kids, :epipen_other_dosage_text, :string	


  	remove_column :kids, :allergy, :text
  	remove_column :kids, :medications, :text
  	remove_column :kids, :diet_restrictions, :text

  	add_column :kids, :allergy_description_one, :string
  	add_column :kids, :allergy_medication_one, :string
  	add_column :kids, :allergy_symptoms_one, :string
  	add_column :kids, :allergy_expiry_one, :date
  	add_column :kids, :allergy_actions_one, :text
  	add_column :kids, :allergy_epipen_one, :boolean
  	add_column :kids, :allergy_private_one, :boolean

  	add_column :kids, :allergy_description_two, :string
  	add_column :kids, :allergy_medication_two, :string
  	add_column :kids, :allergy_symptoms_two, :string
  	add_column :kids, :allergy_expiry_two, :date
  	add_column :kids, :allergy_actions_two, :text
  	add_column :kids, :allergy_epipen_two, :boolean
  	add_column :kids, :allergy_private_two, :boolean

  	add_column :kids, :allergy_description_three, :string
  	add_column :kids, :allergy_medication_three, :string
  	add_column :kids, :allergy_symptoms_three, :string
  	add_column :kids, :allergy_expiry_three, :date
  	add_column :kids, :allergy_actions_three, :text
  	add_column :kids, :allergy_epipen_three, :boolean
  	add_column :kids, :allergy_private_three, :boolean

  	add_column :kids, :food_description_one, :string
  	add_column :kids, :food_medication_one, :string
  	add_column :kids, :food_symptoms_one, :string
  	add_column :kids, :food_expiry_one, :date
  	add_column :kids, :food_actions_one, :text
  	add_column :kids, :food_epipen_one, :boolean
  	add_column :kids, :food_private_one, :boolean

  	add_column :kids, :food_description_two, :string
  	add_column :kids, :food_medication_two, :string
  	add_column :kids, :food_symptoms_two, :string
  	add_column :kids, :food_expiry_two, :date
  	add_column :kids, :food_actions_two, :text
  	add_column :kids, :food_epipen_two, :boolean
  	add_column :kids, :food_private_two, :boolean

  	add_column :kids, :food_description_three, :string
  	add_column :kids, :food_medication_three, :string
  	add_column :kids, :food_symptoms_three, :string
  	add_column :kids, :food_expiry_three, :date
  	add_column :kids, :food_actions_three, :text
  	add_column :kids, :food_epipen_three, :boolean
  	add_column :kids, :food_private_three, :boolean


  end
end
