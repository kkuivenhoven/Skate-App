json.array!(@ratings) do |rating|
  json.extract! rating, :id, :difficulty, :police, :pedestrian, :time, :description
  json.url rating_url(rating, format: :json)
end
