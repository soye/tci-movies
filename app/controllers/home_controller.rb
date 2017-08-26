class HomeController < ApplicationController
  def index
    @recent_reviews = Review.order_by_recent.limit(4)
    @movies = Movie.order_by_popularity.limit(5)
  end
end
