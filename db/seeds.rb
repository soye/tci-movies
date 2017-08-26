require 'tmdb'

Genre.delete_all
genres = TMDB.get_genres
genres.each do |genre|
  Genre.create!(genre)
  puts genre["name"] + " has been added to the database"
end
puts "there are #{Genre.count} genres in the database"