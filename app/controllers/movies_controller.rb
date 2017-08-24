class MoviesController < ApplicationController
  require 'TMDB'

  def index
  end

  def show
    @movie = TMDB.get_movie(params[:id])
  end
end