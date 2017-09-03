class Kid < ActiveRecord::Base
	belongs_to :user
	default_scope { order('last_name ASC') }
	acts_as_birthday :dob
	belongs_to :classroom
	has_many :absents

	def absents_count_so_far
		if self.admission_date >= Date.current.beginning_of_year.advance(months: 6)
			self.absents.where("absent_date > ?", Date.current.beginning_of_year).count + 17
		else
			self.absents.where("absent_date > ?", Date.current.beginning_of_year).count
		end
	end

	def ff_rate_current
		if self.classroom == nil 
        	N/A
        elsif self.classroom.end_range == 18 
            self.user.infant_ff_rate_day 
        elsif self.classroom.end_range == 30 
            self.user.toddler_ff_rate_day 
        elsif self.classroom.end_range == 72 
            self.user.preschool_ff_rate_day 
        elsif self.classroom.end_range == 120
            self.user.schoolage_ff_rate_day 
        end 
    end

    def not_anaphylactic?
  		if self.nuts!=true and self.eggs!=true and self.fish!=true and self.milk!=true and self.latex!=true and self.medication!=true and 
  			self.insect_sting!=true and self.asthmatic!=true and (self.emergency_action_plan==nil or self.emergency_action_plan.empty?) and 
  			self.epipen_expiry==nil and (self.epipen_location==nil or self.epipen_location.empty?) and self.epipen_jr_15mg!=true and 
  			self.epipen_30mg!=true and self.epipen_twinject_15mg!=true and self.epipen_twinject_30mg!=true and self.epipen_other_dosage!=true
				return true
			else
				return false
		end
	end

	def flip_date_kid
		if self.classroom == nil 
            "N/A"
        else
            if self.dob == self.dob.beginning_of_month
                self.dob.advance(months: self.classroom.end_range).beginning_of_month.strftime("%B %d, %Y")
            else
                self.dob.advance(months: self.classroom.end_range).beginning_of_month.next_month.strftime("%B %d, %Y")
            end
        end
    end

    def flip_date_kid_query
		if self.classroom == nil 
            self.dob.advance(years: 100).beginning_of_month.next_month
        else
            if self.dob == self.dob.beginning_of_month
                self.dob.advance(months: self.classroom.end_range).beginning_of_month
            else
                self.dob.advance(months: self.classroom.end_range).beginning_of_month.next_month
            end
        end
    end

    def upcoming_flip_date
        if self.classroom == nil
            return false
        elsif self.upcoming_flip_date_calc_end <= Date.today && self.flip_date_kid_query > Date.today && 
            !(self.classroom.end_range == 72 || self.classroom.end_range == 120)
            return true
        else
            return false
        end
    end

    def upcoming_flip_date_calc_end
        if self.dob == self.dob.beginning_of_month
            self.dob.advance(months: self.classroom.end_range - 1).beginning_of_month
        else
            self.dob.advance(months: self.classroom.end_range - 1).beginning_of_month.next_month
        end
    end

    def upcoming_flip_date_calc_start
        if self.dob == self.dob.beginning_of_month
            self.dob.advance(months: self.classroom.start_range - 1).beginning_of_month
        else
            self.dob.advance(months: self.classroom.start_range - 1).beginning_of_month.next_month
        end
    end
                

    def flip_report_criteria?
        if self.classroom == nil
            return false
        elsif self.user.daycare_location == "Daycare 1"
            if self.classroom.class_name == "Infant 1" || self.classroom.class_name == "Toddler 3"
                return true
            end
        elsif self.user.daycare_location == "Daycare 2"
            if self.classroom.class_name == "Infant 2" || self.classroom.class_name == "Infant 3" ||
                self.classroom.class_name == "Toddler 3" || self.classroom.class_name == "Toddler 4"
                return true
            end
        elsif self.user.daycare_location == "Daycare 3"
            if self.classroom.class_name == "Infant 3" || self.classroom.class_name == "Toddler 3"
                return true
            end
        else
            return false
        end
    end

    def split_attendance?
        if Date.today.next_week.beginning_of_week.advance(days: 4).month != Date.today.month
            return true
        else
            return false
        end
    end

end