require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  test "creating a review" do
    visit root_path

    click_on "leave a review"

    fill_in "Email", with: "user@gmail.com"
    fill_in "Comment", with: "I did not like the movie much"

    click_on "Post Review"

    assert_text "I did not like the movie much"
    assert_text "rated by user@gmail.com"
  end
end