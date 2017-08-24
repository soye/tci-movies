class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rating, :movie, :user, presence: true
end