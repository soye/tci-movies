class Movie < ApplicationRecord
  has_many :reviews
  has_and_belongs_to_many :genres

  validates :tmdb_id, :title, presence: true, uniqueness: true

  scope :order_by_popularity, -> { order("wilson_score DESC") }
end