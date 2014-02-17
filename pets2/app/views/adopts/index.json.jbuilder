json.array!(@adopts) do |adopt|
  json.extract! adopt, :id, :pet_id
  json.url adopt_url(adopt, format: :json)
end
