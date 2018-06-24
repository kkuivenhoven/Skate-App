#Note: the User portion of this seed file comes from: https://www.railstutorial.org/book/updating_and_deleting_users


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
NEW_LINE = "\n"

	SkateSpot.create!(name: "Creekside Park", user_id: 2, number: 1010, 
										street: "Claremont Dr",
										city: "Brentwood", state: "CA", country: "USA",
										zip_code: "94513", latitude: 35.121738, longitude: -120.609989, 
										street_spot: 1, park_spot: 0, gated: 0, concrete: 1, 
										skate_spot_size: 1, street_plaza: 1)
puts "1. Creekside Park created"

	SkateSpot.create!(name: "Yuba City Skatepark", user_id: 3, number: 806,
										street: "Gray Ave",
										city: "Yuba City", state: "CA", country: "USA",
										zip_code: "95991", latitude: 39.135354, longitude: -121.630077,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, 
										neighborhood_spot_size: 1, transition: 1, street_plaza: 0)
puts "2. YC created"

	SkateSpot.create!(name: "Pedlow Skatepark", user_id: 4, number: 17334,
										street: "Victory Blvd",
										city: "Encino", state: "CA", country: "USA",
										zip_code: "91316", latitude: 34.185850, longitude: -118.511441,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, 
										regional_spot_size: 1, transition: 1, street_plaza: 1)
puts "3. Pedlow created"

	SkateSpot.create!(name: "Corning Community Park and Skatepark", user_id: 5, number: 1485,
										street: "Toomes Ave",
										city: "Corning", state: "CA", country: "USA",
										zip_code: "96021", latitude: 39.921631, longitude: -122.191405,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, 
										regional_spot_size: 1, transition: 1, street_plaza: 1)
puts "4. Corning created"

	SkateSpot.create!(name: "Sunken Gardens Neighborhood Park", user_id: 6, number: 3800,
										street: "Pacific Ave",
										city: "Livermore", state: "CA", country: "USA",
										zip_code: "94550", latitude: 37.676079, longitude: 121.750087,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, metal: 0,
										neighborhood_spot_size: 1, transition: 1, street_plaza: 0)
puts "5. Livermore created"

	SkateSpot.create!(name: "Los Osos Skate park", user_id: 8, number: 2180,
										street: "Paslisades Ave",
										city: "Los Osos", state: "CA", country: "USA",
										zip_code: "93402", latitude: 35.312961, longitude: -120.836267,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, wood: 0, 
										neighborhood_spot_size: 1, transition: 1, street_plaza: 0)
puts "6. Los Osos created"

	SkateSpot.create!(name: "Provident Skatepark", user_id: 9, number: 1035,
										street: "W Murray Ave",
										city: "Visalia", state: "CA", country: "USA",
										zip_code: "93291", latitude: 36.333393, longitude: -119.303081,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, wood: 0, 
										neighborhood_spot_size: 1, transition: 1, street_plaza: 1)
puts "7. Provident created"

	SkateSpot.create!(name: "Woodward West", user_id: 2, number: 28400,
										street: "Stallion Springs Dr",
										city: "Tehachapi", state: "CA", country: "USA",
										zip_code: "93561", latitude: 35.080790, longitude: -118.635479,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, wood: 1, 
										regional_spot_size: 1, transition: 1, street_plaza: 1)
puts "8. Woodward created"

	SkateSpot.create!(name: "Sheldon Skatepark", user_id: 5, number: 12511,
										street: "Sheldon St",
										city: "Sun Valley", state: "CA", country: "USA",
										zip_code: "91352", latitude: 34.230936, longitude: -118.406091,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, wood: 0, 
										regional_spot_size: 1, transition: 0, street_plaza: 1)
puts "9. Sheldon created"

	SkateSpot.create!(name: "28th & B Skatepark", user_id: 6, number: 20,
										street: "28th Street",
										city: "Sacramento", state: "CA", country: "USA",
										zip_code: "95816", latitude: 38.586446, longitude: -121.458924,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, wood: 1, metal: 1, 
										regional_spot_size: 1, transition: 1, street_plaza: 1)
puts "10. 28th and B created"

	SkateSpot.create!(name: "Humboldt Neighborhood Skatepark", user_id: 7, number: 265,
										street: "Humboldt Ave",
										city: "Chico", state: "CA", country: "USA",
										zip_code: "95928", latitude: 39.7256124, longitude: -121.83296989999997,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, wood: 0, metal: 0, 
										neighborhood_spot_size: 1, transition: 1, street_plaza: 1)
puts "11. Chico park created"

	SkateSpot.create!(name: "Brentwood Skatepark", user_id: 9,
										street: "Griffith Lane",
										city: "Brentwood", state: "CA", country: "USA",
										zip_code: "94513", latitude: 37.926398, longitude: -121.707277,
										street_spot: false, park_spot: true, gated: 1, concrete: 1, wood: 0, metal: 0, 
										neighborhood_spot_size: 1, transition: 1, street_plaza: 0)
puts "12. Brentwood created"

	User.create!(name:  "Hanna Zanzi",
							 email: "hannazanzi@example.org",
							 password:              "foobar",
							 password_confirmation: "foobar",
							 admin: true,
							 activated: true,
							 activated_at: Time.zone.now)
puts NEW_LINE + "* 1. HZ user created"

	User.create!(name:  "Jamie Thomas",
							 email: "jamiethomas@example.org",
							 password:              "foobar",
							 password_confirmation: "foobar",
							 admin: false,
							 activated: true,
							 activated_at: Time.zone.now)
puts "* 2. JT user created"

	User.create!(name:  "Kendra",
							 email: "kendra@example.org",
							 password:              "foobar",
							 password_confirmation: "foobar",
							 admin: true,
							 activated: true,
							 activated_at: Time.zone.now)
puts "* 3. K user created"

	User.create!(name:  "Leticia Bufoni",
							 email: "leticiabufoni@example.org",
							 password:              "foobar",
							 password_confirmation: "foobar",
							 admin: false,
							 activated: true,
							 activated_at: Time.zone.now)
puts "* 4. LB user created"

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
puts "* 5...20: 15 random users created"



	Event.create!(name: "All Genders Competition", date: Time.zone.now,
								 description: "For all ages",
								 skate_spot_id: SkateSpot.second.id, user_id: 1,
								 zip_code: SkateSpot.second.zip_code,
								 city: SkateSpot.second.city
	)
puts NEW_LINE + ">> 1. event created"

	Event.create!(name: "Girls Competition", date: Time.zone.now,
								 description: "For all ages",
								 skate_spot_id: SkateSpot.first.id, user_id: 2,
								 zip_code: SkateSpot.first.zip_code,
								 city: SkateSpot.first.city
	)
puts ">> 2. event created"

	Rating.create!(difficulty: 1, police: 1, pedestrian: 3, 
								 description: "15-stair near sidewalk. Tore this spot up.",
								 skate_spot_id: 1, user_id: 3)

	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "ledge next to stair-set",
								 skate_spot_id: 1, user_id: 1)

	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "7-stair near sidewalk",
								 skate_spot_id: 3, user_id: 1)

	# Rating.create!(difficulty: 5, police: 5, pedestrian: 0,
	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "10-stair near sidewalk",
								 skate_spot_id: 4, user_id: 1)

	# Rating.create!(difficulty: 5, police: 3, pedestrian: 1,
	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "3-stair",
								 skate_spot_id: 5, user_id: 1)

	# Rating.create!(difficulty: 5, police: 2, pedestrian: 2,
	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "ledge, people sitting",
								 skate_spot_id: 6, user_id: 1)

	# Rating.create!(difficulty: 5, police: 3, pedestrian: 3,
	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "few people sitting",
								 skate_spot_id: 7, user_id: 4)

	# Rating.create!(difficulty: 4, police: 4, pedestrian: 4,
	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "lots of people sitting",
								 skate_spot_id: 8, user_id: 4)

	# Rating.create!(difficulty: 3, police: 4, pedestrian: 0,
	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "no one here except for security",
								 skate_spot_id: 2, user_id: 5)

	# Rating.create!(difficulty: 1, police: 2, pedestrian: 5,
	Rating.create!(difficulty: 1, police: 1, pedestrian: 3,
								 description: "easy skate spot, lots of people",
								 skate_spot_id: 5, user_id: 1)

	Rating.create!(difficulty: 2, police: 2, pedestrian: 4,
								 description: "hang loose",
								 skate_spot_id: 7, user_id: 1)

	Rating.create!(difficulty: 2, police: 2, pedestrian: 4,
								 description: "lorem ipsum",
								 skate_spot_id: 7, user_id: 6)

	Rating.create!(difficulty: 2, police: 2, pedestrian: 4,
								 description: " lorem ipsum",
								 skate_spot_id: 7, user_id: 9)

	Rating.create!(difficulty: 2, police: 2, pedestrian: 4,
								 description: "okay",
								 skate_spot_id: 3, user_id: 5)

puts NEW_LINE + "++ Ratings created"


	Organization.create!(name: "Calling All Skaters", category: "Christian skateboarding", 
									user_id: 3,
									website: "http://www.callingallskaters.org", 
									email: "headquarters@callingallskaters.org",
									phone_num: "", 
									youtube: "https://www.youtube.com/channel/UCuATp5D-rm-vmr-jzhCROYQ", 
									instagram: "callingallskatersofficial", 
									facebook: "", 
									twitter: "", 
									image_logo: "https://static1.squarespace.com/static/544eac4ce4b09c33e858788f/t/559f4e39e4b0da93269c212b/1438042561351/CASCrestBacked.png?format=2500w")

puts NEW_LINE + "<> Organizations created"



=begin
	# Microposts
	users = User.order(:created_at).take(6)
	10.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end
=end

	# Following relationships
	users = User.all
	user  = users.first
	following = users[2..50]
	followers = users[3..40]
	following.each { |followed| user.follow(followed) }
	followers.each { |follower| follower.follow(user) }
puts NEW_LINE + "-> #{user.name} follower and following relationships created"

end
