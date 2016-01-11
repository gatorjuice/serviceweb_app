User.create!([
  {email: "carolinejudd@gmail.com", encrypted_password: "$2a$10$SU.gu93bD4QdvNwgID7EwuDcJ33UhDrT6GXTfmHZpVJzuojlV/yHa", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-12-17 19:32:23", last_sign_in_at: "2015-12-17 19:32:23", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Caroline", last_name: "Judd", admin: false},
  {email: "tricia.dwyer17@gmail.com", encrypted_password: "$2a$10$J1dwhZVxDuvJ6d2FaeP1Wu6fPF2trohzK/j1rwJhWjv6AhNUyjjJa", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-12-17 21:43:17", last_sign_in_at: "2015-12-17 21:43:17", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Tricia", last_name: "Dwyer", admin: false},
  {email: "margaretcmcginnis@gmail.com", encrypted_password: "$2a$10$dnhc6K4GfJgYAEklRczaDOoQn7PrdEVc4MM2xUQ3jfRAO3hssAaPi", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 18, current_sign_in_at: "2016-01-10 01:02:00", last_sign_in_at: "2016-01-09 04:14:26", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Margaret", last_name: "McGinnis", admin: false},
  {email: "rebekah.haenni@gmail.com", encrypted_password: "$2a$10$BfGudouptrJAIL4WmbIac.oNZ8QtL8i4e9udoefG9tmxnZW3XKRgu", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-12-21 01:59:10", last_sign_in_at: "2015-12-21 01:59:10", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Becky", last_name: "Sachdeva", admin: false},
  {email: "peter@anyonecanlearntocode.com", encrypted_password: "$2a$10$1d7H/ifWPBvD5tI5CWTBx.7uTQ4vkeg2KxXTVPjlBrTqZHIsv0psC", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2016-01-10 15:32:58", last_sign_in_at: "2016-01-10 15:32:58", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Peter", last_name: "Jang", admin: false},
  {email: "ispacowanguitar@gmail.com", encrypted_password: "$2a$10$p3pxzIXl5fRMQxm67uK5Seyu215/rNapDFsKnTGvkY783BtwUq4V.", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-12-23 03:20:14", last_sign_in_at: "2015-12-23 03:20:14", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Alex", last_name: "Ispa-Cowan", admin: false},
  {email: "gatorjuice@gmail.com", encrypted_password: "$2a$10$5rBCjVxgGDzclj.vHK1DQetsYHgsif6hMugtOQB45pMPU5C6g2M.e", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 35, current_sign_in_at: "2016-01-10 15:54:53", last_sign_in_at: "2016-01-10 15:52:31", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Jamie", last_name: "Gates", admin: true},
  {email: "sporkn8r@yahoo.com", encrypted_password: "$2a$10$nBZ/4YD29OWGjduUip2ntuPw8TZ14n1qs7bfPEce7H.aKAmFxg776", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2016-01-01 18:00:42", last_sign_in_at: "2016-01-01 18:00:42", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Kevin", last_name: "Knipstein", admin: false},
  {email: "vijay.bangalore@gmail.com", encrypted_password: "$2a$10$uI8upoDOanGvU8siSSM8Nekq6X3LybtW/87seO2QjpW9RNANIbuH.", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2016-01-09 04:17:15", last_sign_in_at: "2016-01-09 04:17:15", current_sign_in_ip: "::1", last_sign_in_ip: "::1", first_name: "Vijay", last_name: "Bangalore", admin: false}
])
Comment.create!([
  {resource_id: 4, user_id: 1, body: "hello ther"},
  {resource_id: 35, user_id: 1, body: "hello there"},
  {resource_id: 35, user_id: 1, body: "santoehr"}
])
CommentRating.create!([
  {user_id: 2, comment_id: 59, rating: 1},
  {user_id: 1, comment_id: 60, rating: 1},
  {user_id: 1, comment_id: 62, rating: 1},
  {user_id: 1, comment_id: 61, rating: 1},
  {user_id: 1, comment_id: 59, rating: 1},
  {user_id: 1, comment_id: 65, rating: -1},
  {user_id: 1, comment_id: 66, rating: 1},
  {user_id: 1, comment_id: 64, rating: 1},
  {user_id: 1, comment_id: 68, rating: 1},
  {user_id: 2, comment_id: 75, rating: 1},
  {user_id: 2, comment_id: 73, rating: 1},
  {user_id: 1, comment_id: 26, rating: 1},
  {user_id: 9, comment_id: 73, rating: 1},
  {user_id: 9, comment_id: 75, rating: 1}
])
Resource.create!([
  {name: "Test", address: "507 Barrington Rd, Grosse Pointe Park, MI 48230, USA", phone: "", description: "", city: "grosse pointe park", state: nil, zip_code: "48230", food: nil, health: nil, shelter: nil, user_id: 1, latitude: 42.362314, longitude: -82.930141, street: "507 Barrington", status: "verified"},
  {name: "Trilogy Behavioral Healthcare", address: "1400 W Greenleaf Ave, Chicago, IL 60626, USA", phone: "7735086100", description: "", city: "Chicago", state: nil, zip_code: "60625", food: true, health: true, shelter: nil, user_id: nil, latitude: 42.0105809, longitude: -87.6665284, street: "1400 W Greenleaf", status: "verified"},
  {name: "Community Counseling Centers of Chicago", address: "4740 N Clark St, Chicago, IL 60640, USA", phone: "7737690205", description: "Community Mental Health Center. Outpatient mental health services and psychiatry. ", city: "Chicago", state: nil, zip_code: "60640", food: nil, health: true, shelter: nil, user_id: nil, latitude: 41.9680226, longitude: -87.6676762, street: "4740 N. Clark St", status: "verified"},
  {name: "Meredith Bakes for People", address: "4810 N Magnolia Ave, Chicago, IL 60640, USA", phone: "8476369107", description: "", city: "Chicago", state: nil, zip_code: "60640", food: true, health: nil, shelter: nil, user_id: nil, latitude: 41.9703133, longitude: -87.663045, street: "", status: "verified"},
  {name: "Greater Chicago Food Repository", address: "4100 W Ann Lurie Pl, Chicago, IL 60632, USA", phone: "", description: "", city: "Chicago", state: nil, zip_code: "60632", food: true, health: nil, shelter: nil, user_id: nil, latitude: 41.8182227, longitude: -87.7270413, street: "4100 W Ann Laurie", status: "verified"},
  {name: "Howard Community Pantry", address: "7648 N Paulina St, Chicago, IL 60626, USA", phone: "7732626622", description: "Food pantry open Mondays 9-11am and Thursdays 3-4pm, must live in 60626 or 60625 area code- bring proof of address. Can only access food pantry once every 30 days.\r\n\r\nFree HIV testing and resources.\r\n", city: "Chicago", state: nil, zip_code: "60626", food: true, health: true, shelter: nil, user_id: nil, latitude: 42.0208028, longitude: -87.6734114, street: "7648 N Paulina Street", status: "verified"},
  {name: "Connections for the Homeless", address: "2121 Dewey Ave, Evanston, IL 60201, USA", phone: "", description: "", city: "Evanston", state: nil, zip_code: "60201", food: true, health: nil, shelter: true, user_id: nil, latitude: 42.056593, longitude: -87.695251, street: "2121 Dewey Ave", status: "verified"}
])
