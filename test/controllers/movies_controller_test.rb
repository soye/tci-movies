require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movies_path
    assert_response :success
    assert_select 'h4', "discover movies..."
  end

  test "should get show" do
    movie = movies(:spirited_away)

    get movie_path(movie)
    assert_response :success
    assert_select 'h4', "Spirited Away"
  end

  # test "show for nonexistent movie id"?
end