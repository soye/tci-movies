require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @review = Review.new(rating: 4, comment: "Heartwarming tour through America's history", movie: movies(:forrest_gump), user: users(:user10))
  end

  test "review should be valid" do
    assert @review.valid?
  end

  test "review should be valid with no comment" do
    @review.comment = ""
    assert @review.valid?
  end

  test "review should have rating" do
    @review.rating = nil
    assert_not @review.save, "saved review without rating"
  end

  test "rating should be between 1 and 5" do
    @review.rating = 0
    assert_not @review.save, "saved review with rating less than 1"

    @review.rating = 10
    assert_not @review.save, "saved review with rating greater than 5"

    @review.rating = 5
    assert @review.save

    @review.rating = 1
    assert @review.save
  end

  test "review should belong to movie" do
    @review.movie = nil
    assert_not @review.save, "saved review without movie"
  end

  test "review should belong to user" do
    @review.user = nil
    assert_not @review.save, "saved review without user"
  end

  test "user cannot create more than one review per movie" do
    duplicate_review = reviews(:sa_1).dup
    assert_not duplicate_review.save, "saved second review from user for given movie"
  end
end