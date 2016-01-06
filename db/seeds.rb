#Note: the User portion of this seed file comes from: https://www.railstutorial.org/book/updating_and_deleting_users


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Rating.create!(difficulty: 1, police: 1,
#               pedestrian: 3, time: "morning",
#               description: "3-stair near sidewalk")

#Rating.create!(difficulty: 3, police: 1,
#               pedestrian: 5, time: "midday",
#               description: "ledge next to stair-set")

#Rating.create!(difficulty: 4, police: 5,
#               pedestrian: 1,time: "night",
#               description: "7-stair near sidewalk")

#Rating.create!(difficulty: 5, police: 5,
#               pedestrian: 0, time: "morning",
#               description: "10-stair near sidewalk")

Location.create!(skate_spot_id: 1,
 			     latitude: 38.817508,
  				 longitude: -121.17225)

#Location.create!(skate_spot_id: 2,
# 			     latitude: 39.729464,
#  				 longitude: -121.825026)

#Location.create!(skate_spot_id: 3,
# 			     latitude: 34.0723575,
#  				 longitude: -118.390966)

SkateSpot.create!(name: "Chico", user_id: 1,
                  zip_code: "95928", location_id: 1)

#SkateSpot.create!(name: "Loomis", user_id: 1,
#                  zip_code: "95650", location_id: 2)

#SkateSpot.create!(name: "Los Angeles", user_id: 1,
                  zip_code: "90210", location_id: 3)

User.create!(name:  "Vanessa Torres",
             email: "vanessa@torres.org",
             password:              "foobar",
             password_confirmation: "foobar",
   			 admin: true,
             activated: true,
 		     activated_at: Time.zone.now)

#60.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!(name:  name,
#               email: email,
#               password:              password,
#               password_confirmation: password,
#               activated: true,
# 		       activated_at: Time.zone.now)
#end
