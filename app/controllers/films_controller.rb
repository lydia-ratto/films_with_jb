class FilmsController < ApplicationController
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
  end

  def show
    set_film
  end

  def edit
    set_film
  end

  def set_film
    @film = Film.find(params[:id])
  end
end
