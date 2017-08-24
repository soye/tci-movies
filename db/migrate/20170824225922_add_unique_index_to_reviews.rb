class AddUniqueIndexToReviews < ActiveRecord::Migration[5.1]
  def change
    add_index :reviews, [:movie_id, :user_id], unique: true
  end
end
