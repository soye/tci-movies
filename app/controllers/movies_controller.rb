class MoviesController < ApplicationController
  require 'tmdb'

  def index
  end

  def show
    @movie = TMDB.get_movie(params[:id])
  end
end