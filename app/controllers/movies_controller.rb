class MoviesController < ApplicationController
  require 'tmdb'

  def index
    @genres = Genre.all
    @movies = TMDB.search_movies()
  end

  def show
    @movie = TMDB.get_movie(params[:id])
    @reviews = Review.where(movie_id: params[:id])
  end

  def search
    @results = TMDB.search_movies(params)
    respond_to do |format|
      format.js
    end
  end
end