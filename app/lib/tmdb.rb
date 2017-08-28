require 'httparty'

class TMDB
  include HTTParty
  format :json

  base_uri 'https://api.themoviedb.org/3'

  attr_accessor :title, :release_date, :genres, :overview, :poster_path, :runtime, :id, :in_db

  class << self
    # returns movie details given movie ID
    def get_movie(movieId)
      response = get("/movie/#{movieId}?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        get_movie_hash(response)
      else
        raise response.response
      end
    end

    # returns list of movies that match the search options
    def discover_movies(options = {})
      url = "/discover/movie?api_key=#{ENV['tmdb_api_key']}"

      options.each do |key, value|
        unless key == "controller" or key == "action"
          url += "&" + key + "=" + value
        end
      end

      puts url

      response = get(url, body: options.to_json)
      if response.success?
        get_movies_from_json(response)
      else
        raise response.response
      end
    end

    def get_popular_movies_by_year(year)
      response = get("/discover/movie?sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=#{year}&api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        get_movies_from_json(response)
      else
        raise response.response
      end
    end

    def get_now_playing
      response = get("/movie/now_playing?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        get_movies_from_json(response)
      else
        raise response.response
      end
    end

    # get list of genres (used for seeding db)
    def get_genres
      response = get("/genre/movie/list?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        genres = Array.new
        response["genres"].each do |genre|
          item = Hash.new
          item["tmdb_id"] = genre["id"]
          item["name"] = genre["name"]
          genres << item
        end
        genres
      else
        raise response.response
      end
    end

    private

    # return array of movies given json response
    def get_movies_from_json(response)
      movies = Array.new
      response["results"].each do |movie|
        movies << get_movie_hash(movie)
      end
      movies
    end

    def get_movie_hash(movieItem)
      movie = Hash.new
      movie["title"] = movieItem["title"]
      movie["release_date"] = movieItem["release_date"]
      if movieItem["genres"]
        movie["genres"] = movieItem["genres"]
      elsif movieItem["genre_ids"]
        genres = Array.new
        movieItem["genre_ids"].each do |id|
          genres << Genre.find(id)
        end
        movie["genres"] = genres
      end
      movie["overview"] = movieItem["overview"]
      movie["poster_path"] = get_full_poster_path(movieItem["poster_path"])
      movie["runtime"] = movieItem["runtime"]
      movie["id"] = movieItem["id"]
      # movie["in_db"] = Movie.exists?(movieItem["id"])
      puts movie
      movie
    end

    # returns url to poster image, with option to specify image dimensions
    def get_full_poster_path(path, size = "w185")
      if path.nil? or path.empty?
        ""
      else
        "http://image.tmdb.org/t/p/" + size + "/" + path
      end
    end
  end
end