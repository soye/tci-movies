class ReviewsController < ApplicationController
  require 'tmdb'

  # before_action :determine_scope

  def index
    if params[:movie_id]
      @reviews = Review.where(movie_id: params[:movie_id]).all
      @movie = TMDB.get_movie(params[:movie_id])
      render 'movie_reviews_index'
    else
      @reviews = Review.all
      render 'reviews_index'
    end
  end

  def show
  end

  def new
    @review = Review.new
    if Movie.exists?(params[:movie_id])
      @movie = Movie.find(params[:movie_id])
    else  # create movie in DB if it does not exist
      movie = TMDB.get_movie(params[:movie_id])
      @movie = Movie.create!(tmdb_id: params[:movie_id], title: movie.title)
    end
  end

  def create
    # create user if user does not already exist
    user_id = nil
    if User.exists?(email: params[:email])
      user_id = User.where(email: params[:email]).first.id
    else
      u = User.create!(email: params[:email])
      user_id = u.id
    end

    # create review
    Review.create!(rating: params[:review][:rating], comment: params[:review][:comment], user_id: user_id, movie_id: params[:movie_id])
    redirect_to movie_reviews_path(params[:movie_id])
  end

  protected

  def determine_scope
    @scope = if params[:movie_id]
      Review.where(movie_id: params[:movie_id])
    else
      Review
    end
  end
end
