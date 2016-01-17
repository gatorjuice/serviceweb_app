json.array!(@unverified_resources) do |resource|
  json.id resource.id
  json.score resource.score
  json.name resource.name
  json.services resource.display_resources
  json.phone resource.phone_with_dashes
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