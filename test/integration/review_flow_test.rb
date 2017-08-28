require 'test_helper'

class ReviewFlowTest < ActionDispatch::IntegrationTest
  test "successfully create review" do
    params = {
      "email" => "sophixer@gmail.com",
      "movie_id" => "351460",
      "review" => {
        "rating"=>"2",
        "comment"=>"the script wasn't great. enjoyed the manga more",
        "movie_id"=>"351460",
        "movie_title"=>"Death Note"
      }
    }

    get movie_path(params["movie_id"])
    assert_response :success

    get new_movie_review_path(params["movie_id"])
    assert_response :success

    post movie_reviews_path(params["movie_id"]), params: params

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "i", "Death Note"
  end
end