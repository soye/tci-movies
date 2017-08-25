class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rating, :movie, :user, presence: true
  validates_numericality_of :rating, only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  validates :user, uniqueness: { scope: :movie, message: "has posted review for this movie already" }

  scope :average_rating, -> { average(:rating) }
  scope :order_by_recent, -> { order("created_at DESC") }

  after_create :update_movie_wilson_score

  def update_movie_wilson_score
    puts WilsonScore.rating_lower_bound(self.movie.reviews.average_rating, self.movie.reviews.count, 1..5)
  end
end