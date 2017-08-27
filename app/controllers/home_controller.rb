class HomeController < ApplicationController
  require 'tmdb'

  def index
    @recent_reviews = Review.order_by_recent.limit(4)
    @movies = TMDB.search_movies()
  end
end