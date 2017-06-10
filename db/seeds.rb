#Note: the User portion of this seed file comes from: https://www.railstutorial.org/book/updating_and_deleting_users


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SkateSpot.create!(name: "South County Skate Park", user_id: 2, number: 1750, 
                  street: "Ramonda Ave",
                  city: "Grover Beach", state: "CA", country: "USA",
                  zip_code: "93433", latitude: 35.121738, longitude: -120.609989)

SkateSpot.create!(name: "Gonzales Skate Park", user_id: 1, 
                  street: "1st St",
                  city: "Gonzales", state: "CA", country: "USA",
                  zip_code: "93926", latitude: 36.505976, longitude: -121.440160)

SkateSpot.create!(name: "Santa Rosa Park", user_id: 1, 
                  street: "Santa Rosa St & Oak St",
                  city: "San Luis Obispo", state: "CA", country: "USA",
                  zip_code: "93405", latitude: 35.289092, longitude: -120.665690)

SkateSpot.create!(name: "Las Animas Skateboard Park", user_id: 2, 
                  street: "Mantelli Dr",
                  city: "Gilroy", state: "CA", country: "USA",
                  zip_code: "95020", latitude: 37.020605, longitude: -121.602261)

SkateSpot.create!(name: "El Estero Skate Park", user_id: 1, number: 725,
                  street: "Pearl St",
                  city: "Monterey", state: "CA", country: "USA",
                  zip_code: "93940", latitude: 36.597348, longitude: -121.887265)

SkateSpot.create!(name: "Delano Skate Park", user_id: 1, number: 1221,
                  street: "Cecil Ave",
                  city: "Delano", state: "CA", country: "USA",
                  zip_code: "93215", latitude: 35.776270, longitude: -119.242268)

SkateSpot.create!(name: "Applegate Skate Park", user_id: 1, number: 1045,
                  street: "W 25th St",
                  city: "Merced", state: "CA", country: "USA",
                  zip_code: "95340", latitude: 37.312461, longitude: -120.483005)

SkateSpot.create!(name: "Patterson Skatepark", user_id: 2, number: 1010,
                  street: "W Las Palmas Ave",
                  city: "Patterson", state: "CA", country: "USA",
                  zip_code: "95363", latitude: 37.466275, longitude: -121.141329)

SkateSpot.create!(name: "El Pescadero Park", user_id: 2, number: 301,
                  street: "Grant Line Rd",
                  city: "Tracy", state: "CA", country: "USA",
                  zip_code: "95376", latitude: 37.754186, longitude: -121.430193)

SkateSpot.create!(name: "Yuba City Skate Park", user_id: 1, number: 806,
                  street: "Gray Ave",
                  city: "Yuba City", state: "CA", country: "USA",
                  zip_code: "95991", latitude: 39.135354, longitude: -121.630077)

SkateSpot.create!(name: "Pedlow Skate Park", user_id: 2, number: 17334,
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

SkateSpot.create!(name: "Zero Gravity Skatepark", user_id: 1, number: 920,
                  street: "N Gateway Dr",
                  city: "Madera", state: "CA", country: "USA",
                  zip_code: "93637", latitude: 36.968082, longitude: -120.067529)

SkateSpot.create!(name: "Los Osos Skate park", user_id: 1, number: 2180,
                  street: "Paslisades Ave",
                  city: "Los Osos", state: "CA", country: "USA",
                  zip_code: "93402", latitude: 35.312961, longitude: -120.836267)

SkateSpot.create!(name: "Provident Skate Park", user_id: 2, number: 1035,
                  street: "W Murray Ave",
                  city: "Visalia", state: "CA", country: "USA",
                  zip_code: "93291", latitude: 36.333393, longitude: -119.303081)

SkateSpot.create!(name: "Melody Park", user_id: 1, number: 5935,
                  street: "E Shields Ave",
                  city: "Fresno", state: "CA", country: "USA",
                  zip_code: "93727", latitude: 36.779950, longitude: -119.685225)

SkateSpot.create!(name: "Woodward West", user_id: 1, number: 28400,
                  street: "Stallion Springs Dr",
                  city: "Tehachapi", state: "CA", country: "USA",
                  zip_code: "93561", latitude: 35.080790, longitude: -118.635479)

SkateSpot.create!(name: "Ronka Underground Skatepark", user_id: 1, number: 4404,
                  street: "Wible Rd",
                  city: "Bakersfield", state: "CA", country: "USA",
                  zip_code: "93313", latitude: 35.315111, longitude: -119.038961)

SkateSpot.create!(name: "Belvedere Skatepark", user_id: 1, number: 4914,
                  street: "East Cesar E Chavez Avenue",
                  city: "East Los Angeles", state: "CA", country: "USA",
                  zip_code: "90022", latitude: 34.040176, longitude: -118.159259)

SkateSpot.create!(name: "Sheldon Skate Park", user_id: 1, number: 12511,
                  street: "Sheldon St",
                  city: "Sun Valley", state: "CA", country: "USA",
                  zip_code: "91352", latitude: 34.230936, longitude: -118.406091)

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

SkateSpot.create!(name: "Brentwood Skate Park", user_id: 3,
                  street: "Griffith Lane",
                  city: "Brentwood", state: "CA", country: "USA",
                  zip_code: "94513", latitude: 37.926398, longitude: -121.707277)

User.create!(name:  "Hanna Zanzi",
             email: "hannazanzi@example.org",
             password:              "foobar",
             password_confirmation: "foobar",
						 admin: true,
             activated: true,
 		         activated_at: Time.zone.now)

User.create!(name:  "Jamie Thomas",
             email: "jamiethomas@example.org",
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

15.times do |n|
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
               user_id: 3
)

Rating.create!(difficulty: 3, police: 1,
               pedestrian: 5,
               description: "ledge next to stair-set",
               skate_spot_id: SkateSpot.second.id,
               user_id: 3 
)
Rating.create!(difficulty: 4, police: 5,
               pedestrian: 1,
               description: "7-stair near sidewalk",
               skate_spot_id: SkateSpot.third.id,
               user_id: 1
)
Rating.create!(difficulty: 5, police: 5,
               pedestrian: 0,
               description: "10-stair near sidewalk",
               skate_spot_id: SkateSpot.fourth.id,
               user_id: 2 
)

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
