# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "faker"

puts "Clearing restaurants and reviews tables"

Review.delete_all
Restaurant.delete_all

puts "Creating restaurants..."
30.times do
  new_restaurant = Restaurant.create!({
    address: Faker::Address.street_address,
    name: Faker::Restaurant.name,
    phone_number: Faker::PhoneNumber.phone_number,
    category: Restaurant::CATEGORIES.sample
  })
end
puts "...Created #{Restaurant.count} restaurants"

puts "Creating reviews..."
200.times do
  new_review = Review.create!({
    rating: (1..5).to_a.sample,
    content: Faker::Restaurant.review,
    restaurant: Restaurant.all.sample
  })
end
puts "...#{Review.count} reviews created"
