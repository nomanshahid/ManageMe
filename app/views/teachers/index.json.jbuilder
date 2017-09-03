json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :first_name, :last_name, :employee_id, :class_name, :class_desc, :class_size
  json.url teacher_url(teacher, format: :json)
end
