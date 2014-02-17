json.array!(@consider_adopts) do |consider_adopt|
  json.extract! consider_adopt, :id, :pet_id, :consider_id
  json.url consider_adopt_url(consider_adopt, format: :json)
end
