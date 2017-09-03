json.array!(@absents) do |absent|
  json.extract! absent, :id, :date
  json.url absent_url(absent, format: :json)
end
