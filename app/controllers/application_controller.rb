class ApplicationController < ActionController::Base

  require "json"
  require "open-uri"

  def find_films(film_title)
    film_title = film_title.gsub(" ", "_")
    film_title = film_title.gsub("\"", "'")
    url = "https://imdb-api.com/en/API/SearchMovie/#{ENV['IMDB_API_KEY']}/#{film_title}"
    film_results = fetch_data(url)
    film_results
  end

  def fetch_data(url)
    results_serialized = URI.open(url).read
    JSON.parse(results_serialized)
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
end
