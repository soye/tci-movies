class MoviesController < ApplicationController
  require 'tmdb'

  def index
    @genres = Genre.all
    @movies = TMDB.discover_movies()
  end

  def show
    @movie = TMDB.get_movie(params[:id])
    @reviews = Review.where(movie_id: params[:id])
  end

  def search
  end

  def discover
    @results = TMDB.discover_movies(params)
    respond_to do |format|
      format.js
    end
  end
end