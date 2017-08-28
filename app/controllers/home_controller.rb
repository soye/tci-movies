class HomeController < ApplicationController
  require 'tmdb'

  def index
    @movies = TMDB.discover_movies
    @recent_reviews = Review.order_by_recent.limit(4)
    @recent_movies = TMDB.get_now_playing
  end

  def about
  end
end