json.array!(@rationales) do |rationale|
  json.extract! rationale, :id
  json.url rationale_url(rationale, format: :json)
end
