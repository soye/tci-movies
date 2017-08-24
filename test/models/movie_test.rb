require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.new(tmdb_id: 8587, title: "The Lion King")
  end

  test "movie should be valid" do
    assert @movie.valid?
  end

  test "tmdb_id should be present" do
    @movie.tmdb_id = nil
    assert_not @movie.save, "saved movie without id"
  end

  test "title should be present" do
    @movie.title = ""
    assert_not @movie.save, "saved movie without title"
  end

  test "movie id should be unique" do
    duplicate_movie = @movie.dup
    @movie.save
    assert_not duplicate_movie.save, "saved movie with same id"
  end
end