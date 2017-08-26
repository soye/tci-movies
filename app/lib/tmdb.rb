require 'httparty'

class TMDB
  include HTTParty
  format :json

  base_uri 'https://api.themoviedb.org/3'

  attr_accessor :title, :release_date, :genres, :overview, :poster_path, :runtime, :id, :in_db

  class << self
    def get_movie(movieId)
      response = get("/movie/#{movieId}?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        get_movie_hash(response)
      else
        raise response.response
      end
    end

    def search_movies(options = {})
      url = "/discover/movie?api_key=#{ENV['tmdb_api_key']}&include_adult=false&include_video=false"
      if options["sort_by"]
        url += "&sort_by=#{options['sort_by']}"
      else
        url += "&sort_by=popularity.desc"
      end

      response = get(url)
      if response.success?
        movies = Array.new
        response["results"].each do |movie|
          movies << get_movie_hash(movie)
        end
        movies
      else
        raise response.response
      end
    end

    def get_popular_movies_by_year(year)
      response = get("/discover/movie?sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=#{year}&api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        movies = Array.new
        response["results"].each do |movie|
          movies << get_movie_hash(movie)
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

    private

    def get_movie_hash(movieItem)
      movie = Hash.new
      movie["title"] = movieItem["title"]
      movie["release_date"] = movieItem["release_date"]
      movie["genres"] = movieItem["genres"]
      movie["overview"] = movieItem["overview"]
      movie["poster_path"] = get_full_poster_path(movieItem["poster_path"])
      movie["runtime"] = movieItem["runtime"]
      movie["id"] = movieItem["id"]
      movie["in_db"] = Movie.exists?(movieItem["id"])
      movie
    end

    def get_full_poster_path(path, size = "w185")
      if path.nil? or path.empty?
        ""
      else
        "http://image.tmdb.org/t/p/" + size + "/" + path
      end
    end
  end
end