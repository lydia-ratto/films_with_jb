class Api::V1::FilmsController < ApplicationController
  before_action :set_film, only: %i[show edit]
  def index
    if params[:query].present?
      if params[:josh_score].blank? && params[:release_year].blank? && params[:genre].blank?
        @films = Film.films_search(params[:query])
      elsif params[:josh_score].present? && params[:release_year].blank? && params[:genre].blank?
        @films = Film.where(josh_score: params[:josh_score]).films_search(params[:query])
      elsif params[:josh_score].blank? && params[:release_year].present? && params[:genre].blank?
        @films = Film.where(release_year: params[:release_year]).films_search(params[:query])
      elsif params[:josh_score].blank? && params[:release_year].blank? && params[:genre].present?
        @films = Film.where(genre: params[:genre]).films_search(params[:query])
      elsif params[:josh_score].present? && params[:release_year].present? && params[:genre].blank?
        @films = Film.where(josh_score: params[:josh_score], release_year: params[:release_year]).films_search(params[:query])
      elsif params[:josh_score].present? && params[:release_year].blank? && params[:genre].present?
        @films = Film.where(josh_score: params[:josh_score], genre: params[:genre]).films_search(params[:query])
      elsif params[:josh_score].blank? && params[:release_year].present? && params[:genre].present?
        @films = Film.where(release_year: params[:release_year], genre: params[:genre]).films_search(params[:query])
      else
        @films = Film.where(josh_score: params[:josh_score], genre: params[:genre]).films_search(params[:query])
      end
    else
      if params[:josh_score].blank? && params[:release_year].blank? && params[:genre].blank?
        @films = Film.all
      elsif params[:josh_score].present? && params[:release_year].blank? && params[:genre].blank?
        @films = Film.where(josh_score: params[:josh_score])
      elsif params[:josh_score].blank? && params[:release_year].present? && params[:genre].blank?
        @films = Film.where(release_year: params[:release_year])
      elsif params[:josh_score].blank? && params[:release_year].blank? && params[:genre].present?
        @films = Film.where(genre: params[:genre])
      elsif params[:josh_score].present? && params[:release_year].present? && params[:genre].blank?
        @films = Film.where(josh_score: params[:josh_score], release_year: params[:release_year])
      elsif params[:josh_score].present? && params[:release_year].blank? && params[:genre].present?
        @films = Film.where(josh_score: params[:josh_score], genre: params[:genre])
      elsif params[:josh_score].blank? && params[:release_year].present? && params[:genre].present?
        @films = Film.where(release_year: params[:release_year], genre: params[:genre])
      else
        @films = Film.where(josh_score: params[:josh_score], genre: params[:genre])
      end
    end

    @genres = Film.all.distinct.pluck(:genre).flatten.sort.uniq

    respond_to do |format|
      format.html
      format.text {
        render partial: 'list.html',
        locals: { films: @films }
      }
    end

    render json: @films
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
    render json: @film
  end

  def film_params
    params.require(:film).permit(:imdb_id, :josh_score, :josh_notes, :date_watched, :seen_before, :location_watched)
  end

end
