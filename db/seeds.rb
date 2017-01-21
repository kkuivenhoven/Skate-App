#Note: the User portion of this seed file comes from: https://www.railstutorial.org/book/updating_and_deleting_users


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rating.create!(difficulty: 1, police: 1,
               pedestrian: 3, 
               description: "15-stair near sidewalk. fucked this spot up."#,
               #skate_spot_id: 1,
               #user_id: 1
)

Rating.create!(difficulty: 3, police: 1,
               pedestrian: 5,
               description: "ledge next to stair-set"#,
               #skate_spot_id: 1,
               #user_id: 2 
)


Rating.create!(difficulty: 4, police: 5,
               pedestrian: 1,
               description: "7-stair near sidewalk"#,
               #skate_spot_id: 1,
               #user_id: 3 
)


Rating.create!(difficulty: 5, police: 5,
               pedestrian: 0,
               description: "10-stair near sidewalk"#,
               #skate_spot_id: 1,
               #user_id: 4 
)


Location.create!(skate_spot_id: 1,
                 address: "265 Humboldt Ave",
                 city: "Chico",
 			     latitude: 38.817508,
  				 longitude: -121.17225)

Location.create!(skate_spot_id: 2,
                 address: "Horseshoe Bar Road",
                 city: "Loomis",
 			     latitude: 39.729464,
  				 longitude: -121.825026)

Location.create!(skate_spot_id: 3,
                 address: "West 8th Street",
                 city: "Chico",
 			     latitude: 34.0723575,
  				 longitude: -118.390966)

SkateSpot.create!(name: "Chico Seed Spot", user_id: 1,
                  street: "265 Humboldt Ave",
                  city: "Chico", state: "CA", country: "USA",
                  zip_code: "95928", location_id: 1)

SkateSpot.create!(name: "Loomis Seed Spot", user_id: 1,
                  street: "8650 Horseshoe Bar Rd",
                  city: "Loomis", state: "CA", country: "USA",
                  zip_code: "95650", location_id: 2)

SkateSpot.create!(name: "Los Angeles Seed Spot", user_id: 1,
                  street: "Sunset Blvd",
                  city: "Los Angeles", state: "CA", country: "USA",
                  zip_code: "90210", location_id: 3)

User.create!(name:  "Vanessa Torres",
             email: "vanessa@torres.org",
             password:              "foobar",
             password_confirmation: "foobar",
   			 admin: true,
             activated: true,
 		     activated_at: Time.zone.now)

User.create!(name:  "Kendra",
             email: "kendra@example.org",
             password:              "foobar",
             password_confirmation: "foobar",
   			 admin: true,
             activated: true,
 		     activated_at: Time.zone.now)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
 		       activated_at: Time.zone.now)
end
