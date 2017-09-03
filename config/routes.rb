Rails.application.routes.draw do
  resources :absents
  resources :rationales
  resources :teachers
  resources :classrooms
  resources :kids
  devise_for :users, :skip => [:sessions]

  as :user do
    get 'login' => "devise/sessions#new", :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root :to => 'kids#index'

post "kids/print_food_restrictions_list" => "kids#print_food_restrictions_list"
post "kids/print_allergy_list" => "kids#print_allergy_list"
post "kids/print_special_med_alerts_list" => "kids#print_special_med_alerts_list"
post "kids/print_special_alerts_list" => "kids#print_special_alerts_list"
post "kids/print_student_list" => "kids#print_student_list"
post "kids/print_teacher_list" => "kids#print_teacher_list"
post "kids/print_email_list" => "kids#print_email_list"
post "kids/print_welcome_package" => "kids#print_welcome_package"
post "kids/print_infant_wp_package" => "kids#print_infant_wp_package"
post "kids/print_attendance" => "kids#print_attendance"
post "kids/print_attendance_two" => "kids#print_attendance_two"
post "kids/print_class_summary" => "kids#print_class_summary"
post "kids/print_upcoming_flips_report" => "kids#print_upcoming_flips_report"
post "kids/print_anaphylactic_form" => "kids#print_anaphylactic_form"
get "kids/:id/print_enrolment_completed" => "kids#print_enrolment_completed"
get "kids/:id/print_15_absent_day_letter" => "kids#print_15_absent_day_letter"
get "kids/:id/print_after_july_1st_letter" => "kids#print_after_july_1st_letter"
get "kids/:id/print_20_consecutive_absent_day_letter" => "kids#print_20_consecutive_absent_day_letter"
get "kids/:id/print_25_absent_day_letter" => "kids#print_25_absent_day_letter"
get "kids/:id/print_33_absent_day_letter" => "kids#print_33_absent_day_letter"
get "kids/:id/print_35_absent_day_letter" => "kids#print_35_absent_day_letter"
get "kids/:id/print_student_review_letter" => "kids#print_student_review_letter"

get "teachers/:id/destroy" => "teachers#destroy"

resources :kids do
  get 'discharge', on: :member
end
resources :kids do
  get 'restore', on: :member
end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
