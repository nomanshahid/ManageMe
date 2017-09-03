class KidsController < ApplicationController
  before_action :set_kid, only: [:show, :edit, :update, :destroy]


  # GET /kids
  # GET /kids.json


  def index
    @user ||= current_user
    @users_wo_admin = User.where.not(daycare_location: nil)
    if Date.today.strftime('%m%d') >= '1224'
      @upcoming_bday = @user.kids.where("strftime('%m%d', dob) >= ? or strftime('%m%d', dob) <= ? ", Date.tomorrow.strftime('%m%d'), 14.days.from_now.strftime('%m%d')).where(discharge_date: nil)
    else
      @upcoming_bday = @user.kids.where("strftime('%m%d', dob) >= ? and strftime('%m%d', dob) <= ? ", Date.tomorrow.strftime('%m%d'), 14.days.from_now.strftime('%m%d')).where(discharge_date: nil)
    end
    if current_user.admin? 
      @kids = Kid.where(discharge_date: nil)
      @archived_kids = Kid.where.not(discharge_date: nil)
      @teachers = Teacher.all
      @classrooms = Classroom.all
      @absent_kids = Kid.where(discharge_date: nil)
    else
      @absent_kids = @user.kids.where(discharge_date: nil)
      @kids = @user.kids.where(discharge_date: nil)
      @archived_kids = @user.kids.where.not(discharge_date: nil)
      @teachers = @user.teachers.all.order("title ASC")
      @classrooms = @user.classrooms.all.order('id ASC')
    end
    @rationales = Rationale.all
  end

  def print_allergy_list
    user ||= current_user
    classrooms = user.classrooms.all.reorder('id ASC').select{|k| k.kids.where(discharge_date: nil).where.not(allergy_description_one: '').count > 0 }
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Allergies_List_Template.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_section("ALLERGIES", classrooms) do |s|
      s.add_field(:class_name, :class_name)
      s.add_table('KIDS', :allergies_report, header: true)  do |t|
        t.add_column(:full_name, :full_name)
        t.add_column(:allergy, :description)
        t.add_column(:desc, :medication)
        t.add_column(:symptoms, :symptoms)
        t.add_column(:action, :actions) 
        end
      end
    end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Allergies List.odt'
end

helper_method :print_allergy_list

def print_food_restrictions_list
    user ||= current_user
    classrooms = user.classrooms.all.reorder('id ASC').select{|k| k.kids.where(discharge_date: nil).where.not(food_description_one: '').count > 0 }
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Food_Restriction_List_Template.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_section("FOOD", classrooms) do |s|
      s.add_field(:class_name, :class_name)
      s.add_table('KIDS', :food_rest_report, header: true)  do |t|
        t.add_column(:full_name, :full_name)
        t.add_column(:food_res, :description)
        t.add_column(:desc, :medication)
        t.add_column(:symptoms, :symptoms)
        t.add_column(:action, :actions) 
        end
      end
    end

  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Food Restrictions List.odt'
end

helper_method :print_food_restrictions_list

def print_special_med_alerts_list
    user ||= current_user
    classrooms = user.classrooms.all.reorder('id ASC').select{|k| k.kids.where(discharge_date: nil).where.not(special_med_description_one: '').count > 0 }
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Special_Med_Alerts_Template.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_section("SPECIAL_MED", classrooms) do |s|
      s.add_field(:class_name, :class_name)
      s.add_table('KIDS', :kids_with_special_med_alerts, header: true)  do |t|
        t.add_column(:full_name) { |k| "#{k.first_name} #{k.last_name}" }
        t.add_column(:special_med, :special_med_description_one)
        t.add_column(:desc, :special_med_medication_one)
        t.add_column(:symptoms, :special_med_symptoms_one)
        t.add_column(:action, :special_med_actions_one)
        end
      end
    end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Special Medical Alerts List.odt'
end

helper_method :print_special_med_alerts_list

def print_special_alerts_list
    user ||= current_user
    classrooms = user.classrooms.all.reorder('id ASC').select{|k| k.kids.where(discharge_date: nil).where.not(special_alerts: '').count > 0 }
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Special_Alerts_Template.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_section("SPECIAL", classrooms) do |s|
      s.add_field(:class_name, :class_name)
      s.add_table('KIDS', :kids_with_special_alerts, header: true)  do |t|
        t.add_column(:full_name) { |k| "#{k.first_name} #{k.last_name}" }
        t.add_column(:special_alerts, :special_alerts)
        end
      end
    end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Special Alerts List.odt'
end

helper_method :print_special_alerts_list

  def print_attendance
    classroom = Classroom.find(params[:id])
    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Class_Attendance_Template.odt") do |r|

    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :daycare_location, current_user.daycare_location
    r.add_field :class_name, classroom.class_name
    r.add_field :start, Date.today.next_week.beginning_of_week.strftime("%B %d, %Y")
    if Date.today.next_week.beginning_of_week.advance(days: 4).month != Date.today.next_week.beginning_of_week.month
      r.add_field :end, Date.today.end_of_month.strftime("%B %d, %Y")
    else
      r.add_field :end, Date.today.next_week.beginning_of_week.advance(days: 4).strftime("%B %d, %Y")
    end

    r.add_table('KIDS', classroom.kids.where(discharge_date: nil), header: true) do |t|
      t.add_column(:name) { |k| k.ba ? "#{k.first_name} #{k.last_name} - B&A" : "#{k.first_name} #{k.last_name}"}
      t.add_column(:f, :student_id)
      t.add_column(:dob) { |k| k.dob.strftime("%b %d, %Y") }
      t.add_column(:flip_date) { |k| k.dob.advance(months: k.classroom.end_range).beginning_of_month.next_month.strftime("%b %d, %Y") }
    end


    r.add_table('RECE', classroom.teachers.where(title: 'RECE')) do |t|
      t.add_column(:rece_name) { |k| "#{k.first_name} #{k.last_name}"}
    end

    r.add_table('STUDENTS', classroom.teachers.where(title: 'Student')) do |t|
      t.add_column(:student_name) { |k| "#{k.first_name} #{k.last_name}" }
    end

    r.add_table('ASSISTANTS', classroom.teachers.where("title = ? or title = ?", 'Assistant', 'P/T Assistant')) do |t|
      t.add_column(:assistant_name) { |k| "#{k.first_name} #{k.last_name}" }
    end
  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'atatchment',
                              filename: "Classroom Attendance - #{classroom.class_name}.odt"
end

helper_method :print_attendance 

def print_attendance_two
    classroom = Classroom.find(params[:id])
    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Class_Attendance_Template.odt") do |r|

    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :daycare_location, current_user.daycare_location
    r.add_field :class_name, classroom.class_name
    r.add_field :start, Date.today.next_month.beginning_of_month.strftime("%B %d, %Y")
    r.add_field :end, Date.today.next_week.beginning_of_week.advance(days: 4).strftime("%B %d, %Y")
    
    r.add_table('KIDS', classroom.kids.where(discharge_date: nil), header: true) do |t|
      t.add_column(:name) { |k| k.ba ? "#{k.first_name} #{k.last_name} - B&A" : "#{k.first_name} #{k.last_name}"}
      t.add_column(:f, :student_id)
      t.add_column(:dob) { |k| k.dob.strftime("%b %d, %Y") }
      t.add_column(:flip_date) { |k| k.dob.advance(months: k.classroom.end_range).beginning_of_month.next_month.strftime("%b %d, %Y") }
    end


    r.add_table('RECE', classroom.teachers.where(title: 'RECE')) do |t|
      t.add_column(:rece_name) { |k| "#{k.first_name} #{k.last_name}"}
    end

    r.add_table('STUDENTS', classroom.teachers.where(title: 'Student')) do |t|
      t.add_column(:student_name) { |k| "#{k.first_name} #{k.last_name}" }
    end

    r.add_table('ASSISTANTS', classroom.teachers.where("title = ? or title = ?", 'Assistant', 'P/T Assistant')) do |t|
      t.add_column(:assistant_name) { |k| "#{k.first_name} #{k.last_name}" }
    end
  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: "Classroom Attendance - #{classroom.class_name}.odt"
end

helper_method :print_attendance_two

def print_student_list
    user ||= current_user
    kids = user.kids.where(discharge_date: nil).reorder(:id)
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Student_List_Template.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_table('KIDS', kids, header: true) do |t|
      t.add_column(:full_name) { |k| "#{k.first_name} #{k.last_name}"}
      t.add_column(:dob) { |k| k.dob.strftime("%B %d, %Y") }
      t.add_column(:class_name) {|k| k.classroom ? k.classroom.class_name : "N/A" }
      t.add_column(:gender, :gender)
      t.add_column(:admission_date) { |k| k.admission_date.strftime("%B %d, %Y") }
      t.add_column(:home_phone, :phone)
      t.add_column(:flip_date) { |k| k.classroom ? k.dob.advance(months: k.classroom.end_range).beginning_of_month.next_month.strftime("%B %d, %Y") : "N/A" }
    end
  end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Student List.odt'
end

helper_method :print_student_list

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

helper_method :in_words

def print_enrolment_completed
    kid = Kid.find(params[:id])
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
  if kid.not_anaphylactic? 
    report_to_gen = "#{Rails.root}/app/reports/Student_Enrolment_Completed_Template.odt"
  else
    report_to_gen = "#{Rails.root}/app/reports/Student_Enrolment_Completed_A_Template.odt"
  end
    report = ODFReport::Report.new(report_to_gen) do |r|

      r.add_field(:id_full, "#{kid.student_id}#{kid.student_number}")
      r.add_field(:full_name, "#{kid.first_name} #{kid.last_name}")
      r.add_field :street, kid.street_addr
      r.add_field :city, kid.city
      r.add_field :province, kid.province
      r.add_field :postal_code, kid.postal_code.capitalize!
      r.add_field :gender, kid.gender
      r.add_field :dob, kid.dob.strftime("%B %d, %Y")
      r.add_field :phone, kid.phone
      r.add_field :religion, kid.religion

      r.add_field :admission_date, kid.admission_date.strftime("%B %d, %Y")
      r.add_field :school_name, kid.school_name
      r.add_field :school_phone, kid.school_phone
      r.add_field :bus_route, kid.bus_route
      r.add_field :bus_driver, kid.bus_driver

      r.add_field :gaurd_one_name, kid.gaurdian_one_name
      r.add_field :gaurd_one_cell, kid.gaurdian_one_mobile_phone
      r.add_field :gaurd_one_email, kid.gaurdian_one_email
      r.add_field :gaurd_one_emp, kid.gaurdian_one_employer
      r.add_field :gaurd_one_work_add, kid.gaurdian_one_employer_addr
      r.add_field :gaurd_one_work, kid.gaurdian_one_bus_phone

      r.add_field :gaurd_two_name, kid.gaurdian_two_name
      r.add_field :gaurd_two_cell, kid.gaurdian_two_mobile_phone
      r.add_field :gaurd_two_email, kid.gaurdian_two_email
      r.add_field :gaurd_two_emp, kid.gaurdian_two_employer
      r.add_field :gaurd_two_work_add, kid.gaurdian_two_employer_addr
      r.add_field :gaurd_two_work, kid.gaurdian_two_bus_phone

      r.add_field(:c1, kid.gaurdian_one_email_corr ? "Yes" : "No, do not" )
      r.add_field(:c2, kid.gaurdian_two_email_corr ? "Yes" : "No, do not" )

      r.add_field :emerg_one_name, kid.emerg_contact_one_name
      r.add_field :emerg_one_relationship, kid.emerg_contact_one_relationship
      r.add_field :emerg_one_home, kid.emerg_contact_one_phone
      r.add_field :emerg_one_work, kid.emerg_contact_one_work
      r.add_field :emerg_one_cell, kid.emerg_contact_one_cell
      r.add_field :emerg_two_name, kid.emerg_contact_two_name
      r.add_field :emerg_two_relationship, kid.emerg_contact_two_relationship
      r.add_field :emerg_two_home, kid.emerg_contact_two_phone
      r.add_field :emerg_two_work, kid.emerg_contact_two_work
      r.add_field :emerg_two_cell, kid.emerg_contact_two_cell
      r.add_field :emerg_three_name, kid.emerg_contact_three_name
      r.add_field :emerg_three_relationship, kid.emerg_contact_three_relationship
      r.add_field :emerg_three_home, kid.emerg_contact_three_phone
      r.add_field :emerg_three_work, kid.emerg_contact_three_work
      r.add_field :emerg_three_cell, kid.emerg_contact_three_cell


      r.add_field(:c3, kid.sunscreen ? "Yes" : "No" )
      r.add_field(:c4, kid.diaper_cream ? "Yes" : "No" )
      r.add_field(:c5, kid.hand_sanitizer ? "Yes" : "No" )
      r.add_field(:c6, kid.face_painting ? "Yes" : "No" )
      r.add_field(:c7, kid.vidpic_taking ? "Yes" : "No" )

      r.add_field :phys_name, kid.physician_name
      r.add_field :phys_addr, kid.physician_addr
      r.add_field :phys_phone, kid.physician_phone
      r.add_field :ohip, kid.ohip

      allergies = []
      for i in 1..5
        if kid.send("allergy_description_#{in_words(i)}").present?
          allergies << {description: kid.send("allergy_description_#{in_words(i)}"), medication: kid.send("allergy_medication_#{in_words(i)}"), 
            symptoms: kid.send("allergy_symptoms_#{in_words(i)}"), expiry: kid.send("allergy_expiry_#{in_words(i)}"), 
            actions: kid.send("allergy_actions_#{in_words(i)}"), epipen: kid.send("allergy_epipen_#{in_words(i)}") }
        end
      end  
      food = []
      for i in 1..5
        if kid.send("food_description_#{in_words(i)}").present?
          food << {description: kid.send("food_description_#{in_words(i)}"), medication: kid.send("food_medication_#{in_words(i)}"), 
            symptoms: kid.send("food_symptoms_#{in_words(i)}"), expiry: kid.send("food_expiry_#{in_words(i)}"), 
            actions: kid.send("food_actions_#{in_words(i)}"), epipen: kid.send("food_epipen_#{in_words(i)}") }
        end
      end

      if !kid.special_med_description_one.present?
        special_med = [] 
      else
        special_med = [{description: kid.special_med_description_one, medication: kid.special_med_medication_one, 
          symptoms: kid.special_med_symptoms_one, expiry: kid.special_med_expiry_one, 
          actions: kid.special_med_actions_one, epipen: kid.special_med_epipen_one}] 
      end

      if !kid.special_alerts.present?
        special_alerts = [] 
      else
        special_alerts = [{sp_a: kid.special_alerts}] 
      end

      r.add_table('ALLERGIES', allergies, header:true)  do |t|
        t.add_column(:desc, :description)
        t.add_column(:med, :medication)
        t.add_column(:symp, :symptoms)
        t.add_column(:exp, :expiry)
        t.add_column(:alg_action, :actions) 
        t.add_column(:ep1) do |allergy|
          allergy[:epipen] ? "Yes" : "No"
        end
      end

      r.add_table('F_REST', food, header:true)  do |t|
        t.add_column(:f_desc, :description)
        t.add_column(:f_med, :medication)
        t.add_column(:f_symp, :symptoms)
        t.add_column(:f_exp, :expiry)
        t.add_column(:f_alg_action, :actions) 
        t.add_column(:ep2) do |food|
          food[:epipen] ? "Yes" : "No"
        end
      end

      r.add_table('SPECIAL_MED', special_med)  do |t|
        t.add_column(:special_med_desc, :description)
        t.add_column(:special_med_med, :medication)
        t.add_column(:special_med_symp, :symptoms)
        t.add_column(:sp_m_exp, :expiry)
        t.add_column(:special_med_action, :actions) 
        t.add_column(:ep3) do |sm|
          sm[:epipen] ? "Yes" : "No"
        end
      end 

      r.add_table('SPECIAL_ALERT', special_alerts)  do |t|
        t.add_column(:special_alert, :sp_a)
      end  

      r.add_field(:a1, kid.nuts ? "Yes" : "No" )
      r.add_field(:a2, kid.fish ? "Yes" : "No" )
      r.add_field(:a3, kid.eggs ? "Yes" : "No" )
      r.add_field(:a4, kid.milk ? "Yes" : "No" )
      r.add_field(:a5, kid.latex ? "Yes" : "No" )
      r.add_field(:a6, kid.medication ? "Yes" : "No" )
      r.add_field(:a7, kid.insect_sting ? "Yes" : "No" )
      r.add_field :med_text, kid.medication_text
      r.add_field :insect_sting_text, kid.insect_sting_text
      r.add_field(:epipen_expiry, kid.epipen_expiry ? kid.epipen_expiry.strftime("%B %d, %Y") : "N/A")
      r.add_field :epipen_location, kid.epipen_location
      r.add_field(:a8, kid.epipen_jr_15mg ? "Yes" : "No" )
      r.add_field(:a9, kid.epipen_twinject_15mg ? "Yes" : "No" )
      r.add_field(:a10, kid.epipen_30mg ? "Yes" : "No" )
      r.add_field(:a11, kid.epipen_twinject_30mg ? "Yes" : "No" )
      r.add_field :other_dosage, kid.epipen_other_dosage
      r.add_field(:a12, kid.asthmatic ? "Yes" : "No" )
      r.add_field :asthma_medication, kid.asthmatic_medication
      r.add_field(:asthma_expiry, kid.asthmatic_medication_expiry ? kid.asthmatic_medication_expiry.strftime("%B %d, %Y") : "N/A")   
      r.add_field :emergency_action_plan, kid.emergency_action_plan
  end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: "#{kid.first_name} #{kid.last_name}.odt"
end

helper_method :print_enrolment_completed

def print_teacher_list
    user ||= current_user
    teachers = user.teachers.all.order(:last_name)
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Teacher_List.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_table('TEACHERS', teachers, header: true) do |t|
      t.add_column(:full_name) { |k| "#{k.first_name} #{k.last_name}"}
      t.add_column(:class_name) {|k| k.classroom ? k.classroom.class_name : "N/A"}
      t.add_column(:phone, :phone)
      t.add_column(:title, :title)
      t.add_column(:class_size) { |k| k.classroom ? "#{k.classroom.kids.where(discharge_date: nil).count}/#{k.classroom.capacity}" : "N/A"} 
    end
  end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Teacher List.odt'
end

def print_email_list
    user ||= current_user
    kids = user.kids.where(discharge_date: nil)
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Email_List.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_table('EMAILS', kids, header: true) do |t|
      t.add_column(:full_name) { |k| "#{k.first_name} #{k.last_name}"}
      t.add_column(:c1) { |k| k.gaurdian_one_email_corr ? "Yes" : "No" }
      t.add_column(:c2) { |k| k.gaurdian_two_email_corr ? "Yes" : "No" }
      t.add_column(:parent_email_one, :gaurdian_one_email)
      t.add_column(:parent_email_two, :gaurdian_two_email)
    end
  end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Email List.odt'
end

helper_method :print_teacher_list

def print_upcoming_flips_report
    user ||= current_user
    kids = user.kids.where(discharge_date: nil).all.select{|k| k.flip_date_kid_query <= Date.current.beginning_of_month.advance(months: 6) && 
      k.flip_date_kid_query >= Date.today && k.flip_report_criteria?}.sort_by{ |k| [k.flip_date_kid_query, k.classroom] }
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Upcoming_Flips_Template.odt") do |r|

    r.add_field(:daycare_location, user.daycare_location)
    r.add_field(:date_today, Date.today.strftime("%B %d, %Y"))

    r.add_table('KIDS',kids, header: true) do |t|
      t.add_column(:full_name) { |k| "#{k.first_name} #{k.last_name}"}
      t.add_column(:class_name) { |k| k.classroom ? k.classroom.class_name : "N/A"}
      t.add_column(:flip_date) { |k| k.flip_date_kid }
      t.add_column(:dob) { |k| k.dob.strftime("%b %d, %Y") }
    end
  end
  send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Upcoming Flips Report.odt'
end

helper_method :print_upcoming_flips_report

def print_welcome_package
    user = current_user
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Welcome_Package_Template.odt") do |r|

    r.add_field :daycare_street, user.street
    r.add_field :daycare_city, user.city
    r.add_field :daycare_province, user.province
    r.add_field :daycare_postal, user.postal
    r.add_field :daycare_phone, user.phone
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Welcome Package - General.odt'
  
end

helper_method :print_welcome_package

def print_15_absent_day_letter
    user = current_user
    kid = Kid.find(params[:id])
    kid.update_attribute(:warning_15_days_issued, true)

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/15_Absent_Days_Template.odt") do |r|

    r.add_field :parent_one, kid.gaurdian_one_name
    r.add_field :parent_two, kid.gaurdian_two_name
    r.add_field :parent_one_street, kid.street_addr
    r.add_field :p_one_city, kid.city
    r.add_field :p_one_province, kid.province
    r.add_field :p_one_postal, kid.postal_code
    r.add_field :parent_one_home, kid.phone
    r.add_field :student_name, kid.first_name + ' ' + kid.last_name
    r.add_field :class_name, kid.classroom ? kid.classroom.class_name : "N/A"
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :year, Date.current.year
    r.add_field :n1, kid.absents_count_so_far
    r.add_field(:n2, kid.user.days_absence_threshold - kid.absents_count_so_far )
    r.add_field :days_threshold, kid.user.days_absence_threshold
    r.add_field :ff_rate, kid.ff_rate_current 

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: '15 Day - Absent Warning Letter.odt'
  
end

helper_method :print_15_absent_day_letter

def print_after_july_1st_letter
    user = current_user
    kid = Kid.find(params[:id])
    kid.update_attribute(:join_after_july_1st_issued, true)

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Absent_After_July_1st_Template.odt") do |r|

    r.add_field :parent_one, kid.gaurdian_one_name
    r.add_field :parent_two, kid.gaurdian_two_name
    r.add_field :parent_one_street, kid.street_addr
    r.add_field :p_one_city, kid.city
    r.add_field :p_one_province, kid.province
    r.add_field :p_one_postal, kid.postal_code
    r.add_field :parent_one_home, kid.phone
    r.add_field :student_name, kid.first_name + ' ' + kid.last_name
    r.add_field :class_name, kid.classroom ? kid.classroom.class_name : "N/A"
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Joining After July 1st Letter.odt'
  
end

helper_method :print_after_july_1st_letter

def print_20_consecutive_absent_day_letter
    user = current_user
    kid = Kid.find(params[:id])
    kid.update_attribute(:warning_20_consecutive_days_issued, true)

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/20_Consecutive_Days_Template.odt") do |r|

    r.add_field :parent_one, kid.gaurdian_one_name
    r.add_field :parent_two, kid.gaurdian_two_name
    r.add_field :parent_one_street, kid.street_addr
    r.add_field :p_one_city, kid.city
    r.add_field :p_one_province, kid.province
    r.add_field :p_one_postal, kid.postal_code
    r.add_field :parent_one_home, kid.phone
    r.add_field :student_name, kid.first_name + ' ' + kid.last_name
    r.add_field :class_name, kid.classroom ? kid.classroom.class_name : "N/A"
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :year, Date.current.year
    r.add_field :n1, kid.absents_count_so_far
    r.add_field(:n2, kid.user.days_absence_threshold - kid.absents_count_so_far )
    r.add_field :ff_rate, kid.ff_rate_current 

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: '20 Consecutive Days - Absent Notice Letter.odt'
  
end

helper_method :print_20_consecutive_absent_day_letter

def print_25_absent_day_letter
    user = current_user
    kid = Kid.find(params[:id])
    kid.update_attribute(:warning_25_days_issued, true)

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/25_Absent_Days_Template.odt") do |r|

    r.add_field :parent_one, kid.gaurdian_one_name
    r.add_field :parent_two, kid.gaurdian_two_name
    r.add_field :parent_one_street, kid.street_addr
    r.add_field :p_one_city, kid.city
    r.add_field :p_one_province, kid.province
    r.add_field :p_one_postal, kid.postal_code
    r.add_field :parent_one_home, kid.phone
    r.add_field :student_name, kid.first_name + ' ' + kid.last_name
    r.add_field :class_name, kid.classroom ? kid.classroom.class_name : "N/A"
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :year, Date.current.year
    r.add_field :n1, kid.absents_count_so_far
    r.add_field(:n2, kid.user.days_absence_threshold - kid.absents_count_so_far )
    r.add_field :days_threshold, kid.user.days_absence_threshold
    r.add_field :ff_rate, kid.ff_rate_current 

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: '25 Day - Absent Warning Letter.odt'
  
end

helper_method :print_25_absent_day_letter

def print_33_absent_day_letter
    user = current_user
    kid = Kid.find(params[:id])
    kid.update_attribute(:warning_33_days_issued, true)

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/33_Absent_Days_Template.odt") do |r|

    r.add_field :parent_one, kid.gaurdian_one_name
    r.add_field :parent_two, kid.gaurdian_two_name
    r.add_field :parent_one_street, kid.street_addr
    r.add_field :p_one_city, kid.city
    r.add_field :p_one_province, kid.province
    r.add_field :p_one_postal, kid.postal_code
    r.add_field :parent_one_home, kid.phone
    r.add_field :student_name, kid.first_name + ' ' + kid.last_name
    r.add_field :class_name, kid.classroom ? kid.classroom.class_name : "N/A"
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :year, Date.current.year
    r.add_field :n1, kid.absents_count_so_far
    r.add_field(:n2, kid.user.days_absence_threshold - kid.absents_count_so_far )
    r.add_field :days_threshold, kid.user.days_absence_threshold
    r.add_field :ff_rate, kid.ff_rate_current 

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: '33 Day - Absent Warning Letter.odt'
  
end

helper_method :print_33_absent_day_letter

def print_35_absent_day_letter
    user = current_user
    kid = Kid.find(params[:id])
    kid.update_attribute(:warning_35_days_issued, true)

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/35_Absent_Days_Template.odt") do |r|

    r.add_field :parent_one, kid.gaurdian_one_name
    r.add_field :parent_two, kid.gaurdian_two_name
    r.add_field :parent_one_street, kid.street_addr
    r.add_field :p_one_city, kid.city
    r.add_field :p_one_province, kid.province
    r.add_field :p_one_postal, kid.postal_code
    r.add_field :parent_one_home, kid.phone
    r.add_field :student_name, kid.first_name + ' ' + kid.last_name
    r.add_field :class_name, kid.classroom ? kid.classroom.class_name : "N/A"
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :year, Date.current.year
    r.add_field :n1, kid.absents_count_so_far
    r.add_field(:n2, kid.user.days_absence_threshold - kid.absents_count_so_far )
    r.add_field :days_threshold, kid.user.days_absence_threshold
    r.add_field :ff_rate, kid.ff_rate_current 

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: '35 Day - Absent Notice Letter.odt'
  
end

helper_method :print_35_absent_day_letter

def print_student_review_letter
    user = current_user
    kid = Kid.find(params[:id])
    kid.update_attribute(:review_letter_issued, true)

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Student_Review_Letter_Template.odt") do |r|

    r.add_field :daycare_street, user.street
    r.add_field :daycare_city, user.city
    r.add_field :daycare_province, user.province
    r.add_field :daycare_postal, user.postal
    r.add_field :daycare_phone, user.phone
    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
    r.add_field :parent_one, kid.gaurdian_one_name
    r.add_field :parent_two, kid.gaurdian_two_name
    r.add_field :parent_one_street, kid.street_addr
    r.add_field :p_one_city, kid.city
    r.add_field :p_one_province, kid.province
    r.add_field :p_one_postal, kid.postal_code
    r.add_field :parent_one_home, kid.phone
    r.add_field :student_id, kid.student_id + kid.student_number.to_s
    r.add_field :student_name, kid.first_name + ' ' + kid.last_name

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: "#{kid.first_name} #{kid.last_name} - Review Letter.odt"
  
end

helper_method :print_student_review_letter

def print_class_summary
    user = current_user
    classrooms = user.classrooms.all.reorder('id ASC')
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Class_Summary_Template.odt") do |r|

    r.add_field :street_addr, user.street
    r.add_field :curr_week, Date.today.beginning_of_week.strftime("%B %d, %Y")

    r.add_table('CLASSES', classrooms, header: true) do |t|
      t.add_column(:class_n, :class_name)
      t.add_column(:c1, :capacity)      
      t.add_column(:e1) { |k| k.kids.where(discharge_date: nil).count }
      t.add_column(:s1) { |k| k.kids.where(discharge_date: nil).where(student_id: "CS").count }
      t.add_column(:ff1) { |k| k.kids.where(discharge_date: nil).where(student_id: "FF").count }
      t.add_column(:sp1) { |k| k.capacity - k.kids.where(discharge_date: nil).count }
    end
    total_capacity = 0
    classrooms.each do |c|
      total_capacity += c.capacity
    end
    r.add_field :ttl, total_capacity
    r.add_field :ettl, user.kids.where(discharge_date: nil).where.not(classroom_id: nil).count
    r.add_field :sttl, user.kids.where(discharge_date: nil).where.not(classroom_id: nil).where(student_id: "CS").count
    r.add_field :ffttl, user.kids.where(discharge_date: nil).where.not(classroom_id: nil).where(student_id: "FF").count
    r.add_field :spttl, total_capacity - user.kids.where(discharge_date: nil).where.not(classroom_id: nil).count 
  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: "#{user.daycare_location.capitalize} - Weekly Class Summary.odt"
  
end

helper_method :print_class_summary

def print_infant_wp_package

  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Infant_WP_Template.odt") do |r|

  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Welcome Package - Infant.odt'
  
end

helper_method :print_infant_wp_package

def print_anaphylactic_form
  # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    report = ODFReport::Report.new("#{Rails.root}/app/reports/Anaphylactic_Template.odt") do |r|

    r.add_field :date_today, Date.today.strftime("%B %d, %Y")
  end
    send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
                              disposition: 'attachment',
                              filename: 'Anaphylactic Form.odt'
  
end

helper_method :print_anaphylactic_form

def restore
  kid = Kid.find(params[:id])
  kid.update_attribute(:discharge_date, nil)
  redirect_to root_url
end


  # GET /kids/1
  # GET /kids/1.json
def show
  kid = Kid.find(params[:id])
  classroom = kid.classroom
  respond_to do |format|
    format.html { render action: 'show' }
    format.json do
      # Return kid as json object
      result = kid.to_json(include: :classroom)
      render json: result
    end
  end
end

  # GET /kids/new
  def new
    @kid = Kid.new
    @teacher = Teacher.new
  end

  # GET /kids/1/edit
  def edit
    @user ||= current_user
    @classrooms = @user.classrooms.all
  end

  def discharge
    @user ||= current_user
    @kid = Kid.find(params[:id])
  end

  # POST /kids
  # POST /kids.json
  def create
    @kid = Kid.new(kid_params)
    @kid.user = current_user
    

    respond_to do |format|
      if @kid.save
        format.html { redirect_to root_url, notice: 'Kid was successfully created.' }
        format.json { render :show, status: :created, location: @kid }
      else
        format.html { render :new }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kids/1
  # PATCH/PUT /kids/1.json
  def update
    respond_to do |format|
      if @kid.update(kid_params)
        format.html { redirect_to root_url, notice: 'Kid was successfully updated.' }
        format.json { render :show, status: :ok, location: @kid }
      else
        format.html { render :edit }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid.destroy
    respond_to do |format|
      format.html { redirect_to kids_url, notice: 'Kid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kid
      @kid = Kid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kid_params
      params.require(:kid).permit!
    end
end
