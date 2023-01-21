class FilmsController < ApplicationController
  before_action :set_film, only: %i[show edit]
  def index
    @films = Film.all
  end

  def show
    set_film
  end

  def create
    film_details = create_film_details(params[:film][:imdb_id])
    all_details = film_params.merge(film_details)
    @film = Film.new(all_details)
    if @film.save
      redirect_to film_path(@film)
    else
      render :new
    end
  end

  def new
    @film = Film.new
    if params[:query].blank?
      @found_films = {}
    else
      @found_films = find_films(params[:query])
    end

  puts @found_films
  end

  def edit
    set_film
  end

  private

  def set_film
    @film = Film.find(params[:id])
  end

  def film_params
    params.require(:film).permit(:imdb_id, :josh_score, :josh_notes, :date_watched, :seen_before, :location_watched)
  end 
  
end
