json.array!(@skate_spots) do |skate_spot|
  json.extract! skate_spot, :id
  json.url skate_spot_url(skate_spot, format: :json)
end
