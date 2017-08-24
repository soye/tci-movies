class Movie < ApplicationRecord
  has_many :reviews

  validates :tmdb_id, :title, presence: true, uniqueness: true
end
