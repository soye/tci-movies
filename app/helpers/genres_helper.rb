module GenresHelper
  # given array of genre items {id: 18, name: "Drama"}, output comma-separated string of genres
  def list_of_genres(genresArray)
    genres_string = ""
    genresArray.each do |g|
      genres_string += g["name"]
      unless g == genresArray.last
        genres_string += ", "
      end
    end
    genres_string
  end
end