require 'httparty'

class TMDB
  include HTTParty
  format :json

  base_uri 'https://api.themoviedb.org/3'

  attr_accessor :title, :release_date, :genres, :overview, :poster_path, :runtime

  def initialize(title, release_date, genres, overview, poster_path, runtime)
    self.title = title
    self.release_date = release_date
    self.genres = genres
    self.overview = overview
    self.poster_path = poster_path
    self.runtime = runtime
  end

  class << self
    def get_movie(movieId)
      response = get("/movie/#{movieId}?api_key=#{ENV['tmdb_api_key']}")
      if response.success?
        self.new(response["title"], response["release_date"], response["genres"], response["overview"], get_full_poster_path(response["poster_path"]), response["runtime"])
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

    def get_full_poster_path(path, size = "w185")
      if path.empty?
        ""
      else
        "http://image.tmdb.org/t/p/" + size + "/" + path
      end
    end
  end
end