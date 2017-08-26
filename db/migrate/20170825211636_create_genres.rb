class CreateGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :genres, id: false do |t|
      t.integer :tmdb_id, primary_key: true
      t.string :name
    end

    create_table :genres_movies, id: false do |t|
      t.belongs_to :genre, index: true
      t.belongs_to :movie, index: true
    end
  end
end
