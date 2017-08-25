class MoviesController < ApplicationController
  require 'tmdb'

  def index
    # @movies = TMDB.get_popular_movies_by_year(Date.today.year)
  end

  def show
    @movie = TMDB.get_movie(params[:id])
  end
end