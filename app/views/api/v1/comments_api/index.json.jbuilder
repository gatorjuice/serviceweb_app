json.array!(@comments) do |comment|
  json.id comment.id
  json.body comment.body
  json.resource_id comment.resource_id
  json.user_id comment.user_id
  json.score comment.total_rating
  json.user_first_name current_user.first_name
  json.created_at comment.created_at
end