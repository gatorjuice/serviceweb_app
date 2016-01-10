json.array!(@resources) do |resource|
  json.id resource.id
  json.status resource.status
  json.name resource.name
  json.address resource.address
  json.street resource.street
  json.city resource.city
  json.zip_code resource.zip_code
  json.description resource.description
  json.comments resource.comments
  json.user resource.user
  json.latitude resource.latitude
  json.longitude  resource.longitude
end