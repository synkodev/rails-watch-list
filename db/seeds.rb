# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'json'

puts '==============   SEED BEGIN  =============='

puts 'Step 1: Deleting all the movies from the database'

Movie.destroy_all

puts 'Step 2: Calling the movies API to generate the data'

movies = JSON.parse(URI.open('https://tmdb.lewagon.com/movie/top_rated').read, symbolize_names: true)[:results]

puts "#{movies.count} movies fetched from the API"
puts 'Step 3: Creating the movies in the database'

# For each movie, insert into the database
movies.each do |movie|
  data = Movie.new(title: movie[:title],
                   overview: movie[:overview],
                   poster_url: "https://image.tmdb.org/t/p/original#{movie[:poster_path]}",
                   rating: movie[:vote_average])
  data.save!
end

puts "#{Movie.count} movies in the database"

puts '===============   SEED END  =============='
