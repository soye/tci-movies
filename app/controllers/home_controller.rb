class HomeController < ApplicationController
  def index
    @recent_reviews = Review.order_by_recent.limit(4)
  end
end
