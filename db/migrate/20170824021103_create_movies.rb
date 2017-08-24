class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies, id: false do |t|
      t.integer :tmdb_id, primary_key: true
      t.string :title

      t.timestamps
    end
  end
end
