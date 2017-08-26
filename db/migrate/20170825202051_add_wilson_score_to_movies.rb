class AddWilsonScoreToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :wilson_score, :float
  end
end