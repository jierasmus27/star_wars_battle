class NewSeriesFilmsController < ApplicationController
  def new
    @new_series_film = NewSeriesFilm.new
  end

  def create
    @new_series_film = NewSeriesFilm.new(new_series_film_params)

    respond_to do |format|
      if @new_series_film.save
        format.html { redirect_to @new_series_film, notice: 'New Series Film was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @new_series_film = NewSeriesFilm.find(params[:id])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def new_series_film_params
    params.require(:new_series_film).permit(:episode_id, :opening_crawl, :director, :producer, :release_date)
  end

end
