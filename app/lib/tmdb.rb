require 'httparty'

class TMDB
  include HTTParty
  format :json

  base_uri 'https://api.themoviedb.org/3'

  attr_accessor :title, :release_date, :genres, :overview, :poster_path, :runtime, :in_db

  def initialize(movieItem)
    self.title = movieItem["title"]
    self.release_date = movieItem["release_date"]
    self.genres = movieItem["genres"]
    self.overview = movieItem["overview"]
    self.poster_path = get_full_poster_path(movieItem["poster_path"])
    self.runtime = movieItem["runtime"]
    self.in_db = Movie.exists?(movieItem["id"])
  end

  def get_full_poster_path(path, size = "w185")
    if path.empty?
      ""
    else
      "http://image.tmdb.org/t/p/" + size + "/" + path
    end
  end

  class << self
    def get_movie(movieId)
      response = get("/movie/#{movieId}?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        new(response)
      else
        raise response.response
      end
    end

    def get_popular_movies_by_year(year)
      response = get("/discover/movie?sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=#{year}&api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        movies = Array.new
        response["results"].each do |movie|
          movies << new(movie)
        end
        movies
      else
        raise response.response
      end
    end

    def get_now_playing
      response = get("/movie/now_playing?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        puts response
      else
        raise response.response
      end
    end

    def get_genres
      response = get("/genre/movie/list?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        puts response
      else
        raise response.response
      end
    end
  end
end