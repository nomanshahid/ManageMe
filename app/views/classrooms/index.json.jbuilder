json.array!(@classrooms) do |classroom|
  json.extract! classroom, :id, :class_name, :capacity
  json.url classroom_url(classroom, format: :json)
end
