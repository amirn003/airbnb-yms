# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'literate_randomizer'

user = User.create!(email: "agnea@gmail.com", password: "hellohello")

20.times do
  flat = Flat.new(
    name: Faker::Name.name,
    description: LiterateRandomizer.paragraph,
    price: (50..1000).to_a.sample,
    address: Faker::Address.full_address,
    user_id: user.id
  )
  flat.save!
end
