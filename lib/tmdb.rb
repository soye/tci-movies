require 'httparty'

class TMDB
  include HTTParty
  format :json

  base_uri 'https://api.themoviedb.org/3'

  def self.get_now_playing
    response = get("/movie/now_playing?api_key=#{ENV['tmdb_api_key']}")
    if response.success?
      puts response
    else
      raise response.response
    end
  end

  def self.get_genres
    response = get("/genre/movie/list?api_key=#{ENV['tmdb_api_key']}")
    if response.success?
      puts response
    else
      raise response.response
    end
  end
end