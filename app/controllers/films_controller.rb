class FilmsController < ApplicationController
  before_action :set_film, only: %i[show edit]
  def index
    @films = Film.all
  end

  def show
    set_film
  end

  def create
    @film = Deck.new(film_params)
    if @film.save
      redirect_to film_path(@deck)
    else
      render :new
    end
  end

  def new
    @film = Film.new
  end

  def edit
    set_film
  end

  private

  def set_film
    @film = Film.find(params[:id])
  end
  
end
