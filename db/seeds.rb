#Note: the User portion of this seed file comes from: https://www.railstutorial.org/book/updating_and_deleting_users


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SkateSpot.create!(name: "Pedlow Skate Park", user_id: 1, number: 17334,
                  street: "Victory Blvd",
                  city: "Encino", state: "CA", country: "USA",
                  zip_code: "91316", latitude: 34.185850, longitude: -118.511441)

SkateSpot.create!(name: "Corning Community Park and Skate Park", user_id: 1, number: 1485,
                  street: "Toomes Ave",
                  city: "Corning", state: "CA", country: "USA",
                  zip_code: "96021", latitude: 39.921631, longitude: -122.191405)

SkateSpot.create!(name: "Sunken Gardens Neighborhood Park", user_id: 1, number: 3800,
                  street: "Pacific Ave",
                  city: "Livermore", state: "CA", country: "USA",
                  zip_code: "94550", latitude: 37.676079, longitude: 121.750087)

SkateSpot.create!(name: "28th & B Skate Park", user_id: 1, number: 20,
                  street: "28th Street",
                  city: "Sacramento", state: "CA", country: "USA",
                  zip_code: "95816", latitude: 38.586446, longitude: -121.458924)

SkateSpot.create!(name: "Humboldt Neighborhood Skate Park", user_id: 1, number: 265,
                  street: "Humboldt Ave",
                  city: "Chico", state: "CA", country: "USA",
                  zip_code: "95928", latitude: 39.7256124, longitude: -121.83296989999997)

SkateSpot.create!(name: "Loomis Seed Spot", user_id: 1, number: 8650,
                  street: "Horseshoe Bar Rd",
                  city: "Loomis", state: "CA", country: "USA",
                  zip_code: "95650", latitude: 38.808222, longitude: -121.14308399999999)

SkateSpot.create!(name: "Los Angeles Seed Spot", user_id: 1,
                  street: "Sunset Blvd",
                  city: "Los Angeles", state: "CA", country: "USA",
                  zip_code: "90210", latitude: 34.0810165, longitude: -118.41264519999999)

SkateSpot.create!(name: "Brentwood Skate Park", user_id: 2,
                  street: "Griffith Lane",
                  city: "Brentwood", state: "CA", country: "USA",
                  zip_code: "94513", latitude: 37.926398, longitude: -121.707277)

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



Rating.create!(difficulty: 1, police: 1,
               pedestrian: 3, 
               description: "15-stair near sidewalk. Tore this spot up.",
               skate_spot_id: SkateSpot.first.id,
               #user_id: 1
)

Rating.create!(difficulty: 3, police: 1,
               pedestrian: 5,
               description: "ledge next to stair-set",
               skate_spot_id: SkateSpot.second.id,
               #user_id: 2 
)
Rating.create!(difficulty: 4, police: 5,
               pedestrian: 1,
               description: "7-stair near sidewalk",
               skate_spot_id: SkateSpot.third.id,
               #user_id: 3 
)
Rating.create!(difficulty: 5, police: 5,
               pedestrian: 0,
               description: "10-stair near sidewalk",
               skate_spot_id: SkateSpot.fourth.id,
               #user_id: 4 
)



