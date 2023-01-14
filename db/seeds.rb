# ------------ dev seed ------------------------

require "faker"

def create_film_details()
  
  title = Faker::Movie.title
  release_year = rand(1970..2022)
  imdb_id = "#{title} #{release_year}"
  director = Faker::Movies::HarryPotter.character
  genre = [Faker::Book.genre, Faker::Book.genre]
  imdb_score = rand(1..10)
  rotten_tom_score = rand(1..100)
  film_length_mins = rand(90..200)
  summary = Faker::Movie.quote
  image_url = "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_Ratio0.6762_AL_.jpg"
  location_watched = "Cinema"
  seen_before = false
  date_watched = Date.today - rand(1000)
  josh_score = rand(1..10)
  josh_notes = "It was good lol"

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
    image_url:,
    location_watched:,
    seen_before:,
    date_watched:,
    josh_score:,
    josh_notes:
  }
end 

Film.destroy_all

puts "All films destroyed"

20.times do
  Film.create!(create_film_details)
  puts "#{Film.last.title} created"
end

puts "-----Films created-------"







# ------------- below is seed for prod -----------------------------------

# require "json"
# require "open-uri"

# def find_film(film_title)
#   url = "https://imdb-api.com/en/API/Search/#{ENV['IMDB_API_KEY']}/#{film_title}"
#   film_results = fetch_data(url)
#   film_results["results"][0]["id"]
# end

# def create_film_details(imdb_id)
#   url = "https://imdb-api.com/en/API/Title/#{ENV['IMDB_API_KEY']}/#{imdb_id}/Ratings,"
#   film_info = fetch_data(url)

#   title = film_info['title']
#   release_year = film_info['year']
#   director = film_info['directors']
#   genre = film_info['genres'].split(',')
#   imdb_score = film_info['imDbRating']
#   rotten_tom_score = film_info['ratings']['rottenTomatoes']
#   film_length_mins = film_info['runtimeMins']
#   summary = film_info['plot']
#   image_url = film_info['image']

#   {
#     imdb_id:,
#     title:,
#     release_year:,
#     director:,
#     genre:,
#     imdb_score:,
#     rotten_tom_score:,
#     film_length_mins:,
#     summary:,
#     image_url:
#   }

# end

# def fetch_data(url)
#   results_serialized = URI.open(url).read
#   JSON.parse(results_serialized)
# end

# Film.destroy_all


# #Josh's spreadsheet info

# require "csv"

# filepath = "lib/assets/jb_films_test.csv"

# CSV.foreach(filepath, headers: :first_row) do |row|
#   josh_title = row['Film'].gsub(' ', '_')
#   film_id = find_film(josh_title)
#   film_details = create_film_details(film_id)

#   film_details[:location_watched] = row['Cinema']
#   film_details[:seen_before] = row['Seen Before?']
#   film_details[:date_watched] = row['Date']
#   film_details[:josh_score] = row['/10']
#   film_details[:josh_notes] = row['Notes']

#   Film.create(film_details)
# end
