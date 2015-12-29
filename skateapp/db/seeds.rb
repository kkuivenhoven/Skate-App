#Note: the User portion of this seed file comes from: https://www.railstutorial.org/book/updating_and_deleting_users


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Location.create!(skate_spot_id: 1,
 			     latitude: 40.71209,
  				 longitude: -73.95427)

SkateSpot.create!(name: "Granite",
                  user_id: 1,
                  zip_code: "11211")

User.create!(name:  "Vanessa Torres",
             email: "vanessa@torres.org",
             password:              "foobar",
             password_confirmation: "foobar",
   			 admin: true,
             activated: true,
 		     activated_at: Time.zone.now)

60.times do |n|
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
