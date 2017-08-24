class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.integer :movie_id
      t.index :movie_id
      t.integer :user_id
      t.index :user_id

      t.timestamps
    end
  end
end
