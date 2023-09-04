# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts "Destroying Flats..."
Flat.destroy_all


puts "Creating Flats..."
#user = User.create!(email: "agnea@gmail.com", password: "hellohello")

10.times do
  flat = Flat.new(
    name: Faker::Name.name,
    description: LiterateRandomizer.sentence,
    price: (50..1000).to_a.sample,
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user_id: rand(1..3)
  )
  flat.save!
end

puts "Finished!"
