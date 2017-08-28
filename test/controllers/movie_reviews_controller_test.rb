require 'test_helper'

class MovieReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @movie = movies(:spirited_away)

    @params = {
      "email" => "sophixer@gmail.com",
      "movie_id" => "129",
      "review" => {
        "rating"=>"5",
        "comment"=>"Watched this since I was a kid. Amazing film!",
        "movie_id"=>"129",
        "movie_title"=>"Spirited Away"
      }
    }
  end

  test "should get new" do
    get new_movie_review_path(@movie.id)

    assert_response :success
    assert_select 'input[value="Post Review"]'
  end

  test "should redirect upon successful creation" do
    post movie_reviews_path(@movie.id), params: @params

    assert_response :redirect
    follow_redirect!
    assert_select 'h4', "Spirited Away"
  end

  test "should render form again upon unsuccessful creation" do
    @params["email"] = users(:user1).email

    post movie_reviews_path(@movie.id), params: @params

    assert_response :success
    assert_select 'input[value="Post Review"]'
  end
end