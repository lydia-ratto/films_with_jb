# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"

def find_film(film_title)
  url = "https://imdb-api.com/en/API/Search/#{ENV['IMDB_API_KEY']}/#{film_title}"
  film_results = fetch_data(url)
  film_results["results"][0]["id"]
end

def create_film_details(imdb_id)
  url = "https://imdb-api.com/en/API/Title/#{ENV['IMDB_API_KEY']}/#{imdb_id}/Ratings,"
  film_info = fetch_data(url)

  title = film_info['title']
  release_year = film_info['year']
  director = film_info['directors']
  genre = film_info['genres'].split(',')
  imdb_score = film_info['imDbRating']
  rotten_tom_score = film_info['ratings']['rottenTomatoes']
  film_length_mins = film_info['runtimeMins']
  summary = film_info['plot']
  image_url = film_info['image']

  {
    imdb_id:,
    title:,
    release_year:,
    director:,
    genre:,
    imdb_score:,
    rotten_tom_score:,
    film_length_mins:,
    summary:,
    image_url:
  }

end

def fetch_data(url)
  results_serialized = URI.open(url).read
  JSON.parse(results_serialized)
end

Film.destroy_all


#Josh's spreadsheet info

require "csv"

filepath = "lib/assets/jb_films_test.csv"

CSV.foreach(filepath, headers: :first_row) do |row|
  josh_title = row['Film'].gsub(' ', '_')
  film_id = find_film(josh_title)
  film_details = create_film_details(film_id)

  film_details[:location_watched] = row['Cinema']
  film_details[:seen_before] = row['Seen Before?']
  film_details[:date_watched] = row['Date']
  film_details[:josh_score] = row['/10']
  film_details[:josh_notes] = row['Notes']

  Film.create(film_details)
end
