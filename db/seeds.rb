Comment.create!([
  {resource_id: 1, user_id: 2, body: "asdf"}
])
Resource.create!([
  {name: "Hook Up With Us", address: "2027-2099 S Michigan Ave, Chicago, IL 60616, USA", phone: "3121234123", description: "The best is great", city: "Chicago", state: nil, zip_code: "60603", food: nil, health: true, shelter: nil, user_id: 1, latitude: 41.8550926, longitude: -87.623853, street: "2033 S. Michigan Ave.", status: "unverified", shares: 1},
  {name: "Food Resource", address: "4100 W Ann Lurie Pl, Chicago, IL 60632, USA", phone: "3121231234", description: "this is some test stuff", city: "Chicago", state: nil, zip_code: "60632", food: true, health: nil, shelter: nil, user_id: 2, latitude: 41.8182227, longitude: -87.7270413, street: "4100 W Ann Laurie", status: "unverified", shares: 0},
  {name: "Shelter Resource", address: "4711 N Ravenswood Ave, Chicago, IL 60640, USA", phone: "7737849000", description: "shelter resource", city: "Chicago", state: nil, zip_code: "60640", food: nil, health: nil, shelter: true, user_id: 2, latitude: 41.9676645, longitude: -87.673694, street: "4711 N Ravenswood", status: "unverified", shares: 0}
])
ResourceRating.create!([
  {resource_id: 1, user_id: 2, rating: 1},
  {resource_id: 2, user_id: 2, rating: 1},
  {resource_id: 3, user_id: 2, rating: 1}
])
