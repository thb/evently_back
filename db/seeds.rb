# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

places = Place.create([
  { name: "Theatre Royal", address: "Theatre Royal, 2-4 Oxford St, Norwich NR2 1NH" },
  { name: "The Garage", address: "The Garage, 20-22 St. Benedicts St, Norwich NR2 4PG" },
])

categories = Category.create([
  { name: "Music" },
  { name: "Comedy" },
])

events = Event.create([
  { name: "Beatles Concert", description: "Pop Rock", place_id: places.first.id, category_id: categories.first.id, starts_at: Time.now},
  { name: "Rolling Stones Concert", description: "Blues Rock", place_id: places.last.id, category_id: categories.last.id, starts_at: Time.now},
])
