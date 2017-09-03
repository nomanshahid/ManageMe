// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require bootstrap

$(document).ready(function(){
    $(".fake-autofill-fields").show();
        // some DOM manipulation/ajax here
        window.setTimeout(function () {
            $(".fake-autofill-fields").hide();
        },50);

    $(".login-fields").hide(0).delay(2300).fadeIn(1100)
    $(".login h1").hide(0).delay(800).fadeIn(1100)

    // View classroom details on row click
    $("#classroom_table").find('tr[data-id]').on('dblclick', function () {
        var classroom_id = $(this).data('id');
        $("#showClassModal" + classroom_id).modal("show");
    });

    // View absent details on row click
    $("#absent_table").find('tr[data-id]').on('dblclick', function () {
        var absent_id = $(this).data('id');
        $("#showAbsentModal" + absent_id).modal("show");
    });


    // View Teacher details on row click
    $("#teacher_table").find('tr[data-id]').on('dblclick', function () {
        var teacher_id = $(this).data('id');
        $("#editTeacherBtn").click(function(){
            location.href = "/teachers/" + teacher_id + "/edit"
        });
        $.getJSON("/teachers/" + teacher_id, function(data) {
             $('#showTeacherHeader').html(data.first_name + ' ' + data.last_name);
    
    $('#teacher_name_show').html(data.first_name + ' ' + data.last_name);
    $('#teacher_title_show').html(data.title);
    $('#teacher_emp_id_show').html(data.employee_id);
    $('#teacher_phone_show').html(data.phone);
    $('#teacher_alt_phone_show').html(data.alt_phone);
    $('#showTeacherModal').modal('show');   
    $("#deleteTeacherBtn").attr("href", "/teachers/" + teacher_id + "/destroy");
        });        
    })

    // JS for View Modal
    $("#kid_table").find('tr[data-id]').on('dblclick', function () {
    	var kid_id = $(this).data('id');

    // Disable edit button until data complete
    (function() {
        $('.disabledEdit').keyup(function() {

            var empty = false;
            $('.disabledEdit').each(function() {
                if ($(this).val() == '') {
                    empty = true;
                }
            });

            if (empty) {
                $('#editStudentConfirmBtn').attr('disabled', 'disabled');
            } else {
                $('#editStudentConfirmBtn').removeAttr('disabled');
            }
        });
    })()
    
    $('#editStudentConfirmBtn').click(function(){
        $.ajax({
          success: function(result) {
            window.location.href = '/kids/' + kid_id + '/edit'
        }
    });
    });
    $('#discharge_student_btn').click(function() { location.href = '/kids/' + kid_id + '/discharge' });
    $('#print_student_btn').click(function() { location.href = '/kids/' + kid_id + '/print_enrolment_completed' });
    $.getJSON("/kids/" + kid_id, function(data) {
        $("#child_name").val(data.first_name + " " + data.last_name);
    // Render the modal body here
    // first_name = data.first_name, last_name = data.last_name etc
    $('#showTitle').html(data.first_name + ' ' + data.last_name);
    $('#kid_id_absent').val(data.id);
    //Tab 1
    $('[id^=showKid_]').each(function() {
        var field = this.id.split(/_(.+)/)[1];
        $('#' + this.id).html(data[field]);
    });
    $('#first_name_show').html(data.first_name);
    $('#last_name_show').html(data.last_name);
    $('#dob_show').html(data.dob);
    $('#gender_show').html(data.gender);
    $('#religion_show').html(data.religion);
    $('#admission_date_show').html(data.admission_date);
    $('#street_addr_show').html(data.street_addr);
    $('#city_show').html(data.city);
    $('#province_show').html(data.province);
    $('#postal_code_show').html(data.postal_code);
    $('#phone_show').html(data.phone);
    $('#student_id_show').html(data.student_id + (data.student_number ? data.student_number : ' '));
    $('#age_group_show').html(data.classroom ? data.classroom.class_name : "N/A");
    data.ba ? $('#ba_show').html('Yes') : $('#ba_show').html('No')
    $('#school_name_show').html(data.school_name);
    $('#school_phone_show').html(data.school_phone);
    $('#bus_route_show').html(data.bus_route);
    $('#bus_driver_show').html(data.bus_driver);
    data.sunscreen ? $('#sunscreen_show').html('Yes') : $('#sunscreen_show').html('No');
    data.diaper_cream ? $('#diaper_show').html('Yes') : $('#diaper_show').html('No');
    data.hand_sanitizer ? $('#hand_sanitizer_show').html('Yes') : $('#hand_sanitizer_show').html('No');
    data.face_painting ? $('#face_painting_show').html('Yes') : $('#face_painting_show').html('No');
    data.vidpic_taking ? $('#vidpic_taking_show').html('Yes') : $('#vidpic_taking_show').html('No');
    $('#notes_show').html(data.notes);
    // Tab 2
    $('#gaurdian_one_name_show').html(data.gaurdian_one_name);
    $('#gaurdian_one_relationship_show').html(data.gaurdian_one_relationship);
    $('#gaurdian_one_home_phone_show').html(data.gaurdian_one_home_phone);
    $('#gaurdian_one_mobile_phone_show').html(data.gaurdian_one_mobile_phone);
    $('#gaurdian_one_bus_phone_show').html(data.gaurdian_one_bus_phone);
    $('#gaurdian_one_email_show').html(data.gaurdian_one_email);
    data.gaurdian_one_email_corr ? $('#email_corr_one_show').html('Yes,') : $('#email_corr_one_show').html('No, do not');
    $('#gaurdian_one_employer_show').html(data.gaurdian_one_employer);
    $('#gaurdian_one_employer_addr_show').html(data.gaurdian_one_employer_addr);
    $('#gaurdian_one_notes_show').html(data.gaurdian_one_notes);
    $('#gaurdian_two_name_show').html(data.gaurdian_two_name);
    $('#gaurdian_two_relationship_show').html(data.gaurdian_two_relationship);
    $('#gaurdian_two_home_phone_show').html(data.gaurdian_two_home_phone);
    $('#gaurdian_two_mobile_phone_show').html(data.gaurdian_two_mobile_phone);
    $('#gaurdian_two_bus_phone_show').html(data.gaurdian_two_bus_phone);
    $('#gaurdian_two_email_show').html(data.gaurdian_two_email);
    data.gaurdian_two_email_corr ? $('#email_corr_two_show').html('Yes,') : $('#email_corr_two_show').html('No, do not');
    $('#gaurdian_two_employer_show').html(data.gaurdian_two_employer);
    $('#gaurdian_two_employer_addr_show').html(data.gaurdian_two_employer_addr);
    $('#gaurdian_two_notes_show').html(data.gaurdian_two_notes);
    // Tab 3
    $('#emerg_contact_one_name_show').html(data.emerg_contact_one_name);
    $('#emerg_contact_one_phone_show').html(data.emerg_contact_one_phone);
    $('#emerg_contact_one_cell_show').html(data.emerg_contact_one_cell);
    $('#emerg_contact_one_work_show').html(data.emerg_contact_one_work);
    $('#emerg_contact_one_relationship_show').html(data.emerg_contact_one_relationship);
    $('#emerg_contact_two_name_show').html(data.emerg_contact_two_name);
    $('#emerg_contact_two_phone_show').html(data.emerg_contact_two_phone);
    $('#emerg_contact_two_cell_show').html(data.emerg_contact_two_cell);
    $('#emerg_contact_two_work_show').html(data.emerg_contact_two_work);
    $('#emerg_contact_two_relationship_show').html(data.emerg_contact_two_relationship);
    $('#emerg_contact_three_name_show').html(data.emerg_contact_three_name);
    $('#emerg_contact_three_phone_show').html(data.emerg_contact_three_phone);
    $('#emerg_contact_three_cell_show').html(data.emerg_contact_three_cell);
    $('#emerg_contact_three_work_show').html(data.emerg_contact_three_work);
    $('#emerg_contact_three_relationship_show').html(data.emerg_contact_three_relationship);
    $('#physician_name_show').html(data.physician_name);
    $('#physician_phone_show').html(data.physician_phone);
    $('#physician_fax_show').html(data.physician_fax);
    $('#physician_addr_show').html(data.physician_addr);
    $('#physician_city_show').html(data.physician_city);
    $('#physician_postal_code_show').html(data.physician_postal_code);
    $('#ohip_show').html(data.ohip);
    $('#physician_notes_show').html(data.physician_notes);
    // Tab 4
    $('#allergy_desc_one_show').val(data.allergy_description_one);
    $('#allergy_symptoms_one_show').val(data.allergy_symptoms_one);
    $('#allergy_medication_one_show').val(data.allergy_medication_one);
    $('#allergy_expiry_one_show').val(data.allergy_expiry_one);
    $('#allergy_action_one_show').val(data.allergy_actions_one);
    data.allergy_epipen_one ? $('#allergy_epipen_one_show').html('Yes') : $('#allergy_epipen_one_show').html('No');
    if (data.allergy_description_two) {$('#allergy_two').show();}
    $('#allergy_desc_two_show').val(data.allergy_description_two);
    $('#allergy_symptoms_two_show').val(data.allergy_symptoms_two);
    $('#allergy_medication_two_show').val(data.allergy_medication_two);
    $('#allergy_expiry_two_show').val(data.allergy_expiry_two);
    $('#allergy_action_two_show').val(data.allergy_actions_two);
    data.allergy_epipen_two ? $('#allergy_epipen_two_show').html('Yes') : $('#allergy_epipen_two_show').html('No');
    if (data.allergy_description_three) {$('#allergy_three').show();}
    $('#allergy_desc_three_show').val(data.allergy_description_three);
    $('#allergy_symptoms_three_show').val(data.allergy_symptoms_three);
    $('#allergy_medication_three_show').val(data.allergy_medication_three);
    $('#allergy_expiry_three_show').val(data.allergy_expiry_three);
    $('#allergy_action_three_show').val(data.allergy_actions_three);
    data.allergy_epipen_three ? $('#allergy_epipen_three_show').html('Yes') : $('#allergy_epipen_three_show').html('No');
    if (data.allergy_description_four) {$('#allergy_four').show();}
    $('#allergy_desc_four_show').val(data.allergy_description_four);
    $('#allergy_symptoms_four_show').val(data.allergy_symptoms_four);
    $('#allergy_medication_four_show').val(data.allergy_medication_four);
    $('#allergy_expiry_four_show').val(data.allergy_expiry_four);
    $('#allergy_action_four_show').val(data.allergy_actions_four);
    data.allergy_epipen_four ? $('#allergy_epipen_four_show').html('Yes') : $('#allergy_epipen_four_show').html('No');
    if (data.allergy_description_five) {$('#allergy_five').show();}
    $('#allergy_desc_five_show').val(data.allergy_description_five);
    $('#allergy_symptoms_five_show').val(data.allergy_symptoms_five);
    $('#allergy_medication_five_show').val(data.allergy_medication_five);
    $('#allergy_expiry_five_show').val(data.allergy_expiry_five);
    $('#allergy_action_five_show').val(data.allergy_actions_five);
    data.allergy_epipen_five ? $('#allergy_epipen_five_show').html('Yes') : $('#allergy_epipen_five_show').html('No');

    $('#food_desc_one_show').val(data.food_description_one);
    $('#food_symptoms_one_show').val(data.food_symptoms_one);
    $('#food_medication_one_show').val(data.food_medication_one);
    $('#food_expiry_one_show').val(data.food_expiry_one);
    $('#food_action_one_show').val(data.food_actions_one);
    data.food_epipen_one ? $('#food_epipen_one_show').html('Yes') : $('#food_epipen_one_show').html('No');
    if (data.food_description_two) {$('#food_two').show();}
    $('#food_desc_two_show').val(data.food_description_two);
    $('#food_symptoms_two_show').val(data.food_symptoms_two);
    $('#food_medication_two_show').val(data.food_medication_two);
    $('#food_expiry_two_show').val(data.food_expiry_two);
    $('#food_action_two_show').val(data.food_actions_two);
    data.food_epipen_two ? $('#food_epipen_two_show').html('Yes') : $('#food_epipen_two_show').html('No');
    if (data.food_description_three) {$('#food_three').show();}
    $('#food_desc_three_show').val(data.food_description_three);
    $('#food_symptoms_three_show').val(data.food_symptoms_three);
    $('#food_medication_three_show').val(data.food_medication_three);
    $('#food_expiry_three_show').val(data.food_expiry_three);
    $('#food_action_three_show').val(data.food_actions_three);
    data.food_epipen_three ? $('#food_epipen_three_show').html('Yes') : $('#food_epipen_three_show').html('No');
    if (data.food_description_four) {$('#food_four').show();}
    $('#food_desc_four_show').val(data.food_description_four);
    $('#food_symptoms_four_show').val(data.food_symptoms_four);
    $('#food_medication_four_show').val(data.food_medication_four);
    $('#food_expiry_four_show').val(data.food_expiry_four);
    $('#food_action_four_show').val(data.food_actions_four);
    data.food_epipen_four ? $('#food_epipen_four_show').html('Yes') : $('#food_epipen_four_show').html('No');
    if (data.food_description_five) {$('#food_five').show();}
    $('#food_desc_five_show').val(data.food_description_five);
    $('#food_symptoms_five_show').val(data.food_symptoms_five);
    $('#food_medication_five_show').val(data.food_medication_five);
    $('#food_expiry_five_show').val(data.food_expiry_five);
    $('#food_action_five_show').val(data.food_actions_five);
    data.food_epipen_five ? $('#food_epipen_five_show').html('Yes') : $('#food_epipen_five_show').html('No');

    $('#special_med_desc_one_show').val(data.special_med_description_one);
    $('#special_med_symptoms_one_show').val(data.special_med_symptoms_one);
    $('#special_med_medication_one_show').val(data.special_med_medication_one);
    $('#special_med_expiry_one_show').val(data.special_med_expiry_one);
    $('#special_med_action_one_show').val(data.special_med_actions_one);
    data.special_med_epipen_one ? $('#special_med_epipen_one_show').html('Yes') : $('#special_med_epipen_one_show').html('No');
    // Tab 5
    data.nuts ? $('#nuts_show').attr("checked", true) : $('#nuts_show').attr("checked", false);
    data.fish ? $('#fish_show').attr("checked", true) : $('#fish_show').attr("checked", false);
    data.eggs ? $('#eggs_show').attr("checked", true) : $('#eggs_show').attr("checked", false);
    data.milk ? $('#milk_show').attr("checked", true) : $('#milk_show').attr("checked", false);
    data.latex ? $('#latex_show').attr("checked", true) : $('#latex_show').attr("checked", false);
    data.medication ? $('#medication_show').attr("checked", true) : $('#medication_show').attr("checked", false);
    data.insect_sting ? $('#insect_sting_show').attr("checked", true) : $('#insect_sting_show').attr("checked", false);
    data.asthmatic ? $('#asthmatic_show').attr("checked", true) : $('#asthmatic_show').attr("checked", false);
    $('#medication_text_show').val(data.medication_text);
    $('#insect_sting_text_show').val(data.insect_sting_text);
    $('#asthmatic_medication_show').val(data.asthmatic_medication);
    $('#asthmatic_medication_expiry_show').val(data.asthmatic_medication_expiry);
    $('#epipen_expiry_show').val(data.epipen_expiry);
    $('#epipen_location_show').val(data.epipen_location);
    data.epipen_jr_15mg ? $('#epipen_jr_15mg_show').attr("checked", true) : $('#epipen_jr_15mg_show').attr("checked", false);
    data.epipen_30mg ? $('#epipen_30mg_show').attr("checked", true) : $('#epipen_30mg_show').attr("checked", false);
    data.epipen_twinject_15mg ? $('#epipen_twinject_15mg_show').attr("checked", true) : $('#epipen_twinject_15mg_show').attr("checked", false);
    data.epipen_twinject_30mg ? $('#epipen_twinject_30mg_show').attr("checked", true) : $('#epipen_twinject_30mg_show').attr("checked", false);
    data.epipen_other_dosage ? $('#epipen_other_dosage_show').attr("checked", true) : $('#epipen_other_dosage_show').attr("checked", false);
    $('#epipen_other_dosage_text_show').val(data.epipen_other_dosage_text);
    $('#emergency_action_plan_show').val(data.emergency_action_plan);
    // Tab 6
    $('#special_alert_text_show').html(data.special_alerts);
    // Display Modal
    $('#showModal').modal('show');    
    });        
    })

// JS for medical info add more tab
$('#allergy_add_one').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        if(old=='+ Add'){
            $('#allergy_add_two').show();
            return '- Remove' 
        } else {
            $('#allergy_add_two').hide();
            return '+ Add';
        }
    });
});

$('#allergy_add_two').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        if(old=='+ Add'){
            $('#allergy_add_three').show();
            return '- Remove' 
        } else {
            $('#allergy_add_three').hide();
            return '+ Add';
        }
    });
});

$('#allergy_add_three').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        if(old=='+ Add'){
            $('#allergy_add_four').show();
            return '- Remove' 
        } else {
            $('#allergy_add_four').hide();
            return '+ Add';
        }
    });
});

// JS for medical info add more tab

$('#allergy_add_four').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        return old=='+ Add' ?  '- Remove' : '+ Add';
    });
});


// JS for medical info add more tab
$('#food_add_one').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        if(old=='+ Add'){
            $('#food_add_two').show();
            return '- Remove' 
        } else {
            $('#food_add_two').hide();
            return '+ Add';
        }
    });
});

$('#food_add_two').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        if(old=='+ Add'){
            $('#food_add_three').show();
            return '- Remove' 
        } else {
            $('#food_add_three').hide();
            return '+ Add';
        }
    });
});

$('#food_add_three').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        if(old=='+ Add'){
            $('#food_add_four').show();
            return '- Remove' 
        } else {
            $('#food_add_four').hide();
            return '+ Add';
        }
    });
});

// JS for medical info add more tab

$('#food_add_four').click(function(){ //you can give id or class name here for $('button')
    $(this).text(function(i,old){
        return old=='+ Add' ?  '- Remove' : '+ Add';
    });
});

$( function() {
    $( "#absentSelect" ).datepicker({ dateFormat: 'yy-mm-dd' });
  } );

$( function() {
    $( "#dischargeSelect" ).datepicker({ dateFormat: 'yy-mm-dd' });
  } );

var height = $(window).height() - 305;
$('table > tbody').css('max-height', height);


// JS for restore button and modal to function correctly

$(document).on("click", "#restoreBtn", function () {
     var kid_id = $(this).data('id');
     $("#confirm_restoreBtn").attr("href", "/kids/" + kid_id + "/restore");
     $.getJSON("/kids/" + kid_id, function(data) {
     $('#restoreBody').html('<p>' + 'Please note that restoring a student can cause the system to crash in cases where \
        the student is part of a renamed/deleted classroom. Are you sure you want to restore ' 
        + data.first_name + ' ' + data.last_name + '?' + '</p>')
    });
}); 


// JS for clearing modal forms

$('.modal').on('hidden.bs.modal', function(){
	$(this).find('form')[0].reset();
});

// JS for switching between main dashboard and archived students

$('#archivedBtn').on('click',function(){
	if($('#dashboard').css('display')!='none'){
		$('#archived').show().siblings('div').hide();
		$('.add-student-btn').hide();
	}
}); 

$('#dashboardBtn').on('click',function(){
	if($('#archived').css('display')!='none'){
		$('#dashboard').show().siblings('div').hide();
		$('.add-student-btn').show();
	}
  })

// JS for switching between main dashboard and teachers/classrooms

$('#teachersBtn').on('click',function(){
    if($('#dashboard').css('display')!='none'){
        $('#teachers').show().siblings('div').hide();
        $('.add-student-btn').hide();
        $('.add-teacher-btn').show();
    }
}); 

$('#dashboardBtn').on('click',function(){
    if($('#teachers').css('display')!='none'){
        $('#dashboard').show().siblings('div').hide();
        $('.add-teacher-btn').hide();
        $('.add-student-btn').show();
    }
  });

// JS for switching between main archived and teachers/classrooms

$('#teachersBtn').on('click',function(){
    if($('#archived').css('display')!='none'){
        $('#teachers').show().siblings('div').hide();
        $('.add-teacher-btn').show();
    }
}); 

$('#archivedBtn').on('click',function(){
    if($('#teachers').css('display')!='none'){
        $('#archived').show().siblings('div').hide();
        $('.add-teacher-btn').hide();
    }
  });

// JS for switching between main dashboard and classrooms

$('#classroomBtn').on('click',function(){
    if($('#dashboard').css('display')!='none'){
        $('#classroom').show().siblings('div').hide();
        $('.add-student-btn').hide();
        $('.add-classroom-btn').show();
    }
}); 

$('#dashboardBtn').on('click',function(){
    if($('#classroom').css('display')!='none'){
        $('#dashboard').show().siblings('div').hide();
        $('.add-student-btn').show();
        $('.add-classroom-btn').hide();
    }
  })

// JS for switching between archived and classrooms

$('#classroomBtn').on('click',function(){
    if($('#archived').css('display')!='none'){
        $('#classroom').show().siblings('div').hide();
        $('.add-classroom-btn').show();
    }
}); 

$('#archivedBtn').on('click',function(){
    if($('#classroom').css('display')!='none'){
        $('#archived').show().siblings('div').hide();
        $('.add-classroom-btn').hide();
    }
  })

// JS for switching between teachers and classrooms

$('#classroomBtn').on('click',function(){
    if($('#teachers').css('display')!='none'){
        $('#classroom').show().siblings('div').hide();
        $('.add-teacher-btn').hide();
        $('.add-classroom-btn').show();
    }
}); 

$('#teachersBtn').on('click',function(){
    if($('#classroom').css('display')!='none'){
        $('#teachers').show().siblings('div').hide();
        $('.add-teacher-btn').show();
        $('.add-classroom-btn').hide();
    }
  });

// Aug 24
// JS for switching between all and absenteeism

$('#absentBtn').on('click',function(){
    if($('#dashboard').css('display')!='none'){
        $('#absents').show().siblings('div').hide();
        $('.add-student-btn').hide();
    }
    else if($('#classroom').css('display')!='none'){
        $('#absents').show().siblings('div').hide();
        $('.add-classroom-btn').hide();
    } 
    else if($('#archived').css('display')!='none'){
        $('#absents').show().siblings('div').hide();
    }
    else if($('#teachers').css('display')!='none'){
        $('#absents').show().siblings('div').hide();
        $('.add-teacher-btn').hide();
    }
}); 

$('#dashboardBtn').on('click',function(){
    if($('#absents').css('display')!='none'){
        $('#dashboard').show().siblings('div').hide();
        $('.add-student-btn').show();
    }
  });
$('#archivedBtn').on('click',function(){
    if($('#absents').css('display')!='none'){
        $('#archived').show().siblings('div').hide();
    }
  });
$('#teachersBtn').on('click',function(){
    if($('#absents').css('display')!='none'){
        $('#teachers').show().siblings('div').hide();
        $('.add-teacher-btn').show();
    }
  });
$('#classroomBtn').on('click',function(){
    if($('#absents').css('display')!='none'){
        $('#classroom').show().siblings('div').hide();
        $('.add-classroom-btn').show();
    }
  });



});