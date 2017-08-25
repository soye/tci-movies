class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rating, :movie, :user, presence: true
  validates_numericality_of :rating, only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  validates :movie, uniqueness: { scope: :user }
end