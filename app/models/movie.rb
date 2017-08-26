class Movie < ApplicationRecord
  has_many :reviews

  validates :tmdb_id, :title, presence: true, uniqueness: true

  scope :order_by_popularity, -> { order("wilson_score DESC") }
end