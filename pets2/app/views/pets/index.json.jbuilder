json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :age, :breed, :coloring, :habits, :image_url, :gender
  json.url pet_url(pet, format: :json)
end
