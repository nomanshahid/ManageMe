class Classroom < ActiveRecord::Base
	has_many :teachers
	has_many :kids
	belongs_to :user
	
	def allergies_report 
		allergies = []
		kids.where(discharge_date: nil).where.not(allergy_description_one: [nil, '']).each do |kid|
			for i in 1..5
				if kid.send("allergy_description_#{in_words(i)}").present?
					allergies << {full_name: kid.first_name + ' ' + kid.last_name, description: kid.send("allergy_description_#{in_words(i)}"), 
					medication: kid.send("allergy_medication_#{in_words(i)}"),	symptoms: kid.send("allergy_symptoms_#{in_words(i)}"), 
					expiry: kid.send("allergy_expiry_#{in_words(i)}"), actions: kid.send("allergy_actions_#{in_words(i)}"), 
					epipen: kid.send("allergy_epipen_#{in_words(i)}") }
				end
			end	
		end
		return allergies
	end
	def food_rest_report
		food = []
		kids.where(discharge_date: nil).where.not(food_description_one: [nil, '']).each do |kid|
			for i in 1..5
				if kid.send("food_description_#{in_words(i)}").present?
					food << {full_name: kid.first_name + ' ' + kid.last_name, description: kid.send("food_description_#{in_words(i)}"), 
					medication: kid.send("food_medication_#{in_words(i)}"),	symptoms: kid.send("food_symptoms_#{in_words(i)}"), 
					expiry: kid.send("food_expiry_#{in_words(i)}"), actions: kid.send("food_actions_#{in_words(i)}"), 
					epipen: kid.send("food_epipen_#{in_words(i)}") }
				end
			end	
		end
		return food
	end	
	def kids_with_special_med_alerts
		kids.where(discharge_date: nil).where.not("special_med_description_one = ? and special_med_description_one = ?", nil, '')
	end
	def kids_with_special_alerts
		kids.where(discharge_date: nil).where.not(special_alerts: '')
	end

	def in_words(num)
		if num == 1
			return "one"
		elsif num == 2
			return "two"
		elsif num == 3
			return "three"
		elsif num == 4
			return "four"
		elsif num == 5
			return "five"
		end
	end
end
