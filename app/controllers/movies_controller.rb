class MoviesController < ApplicationController
  require 'tmdb'

  def index
    @genres = Genre.all
    @movies = TMDB.get_popular_movies_by_year(Date.today.year)
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