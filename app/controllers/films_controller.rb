class FilmsController < ApplicationController
  before_action :set_film, only: %i[show edit]
  def index
    if params[:query].present?
      @films = Film.search_by_title_and_director(params[:query])
      if @films.nil?
        @films = Film.all
      end
    else
      @films = Film.all
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
