require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home index" do
    get root_path
    assert_response :success

    assert_select '.eight.columns' do
      assert_select 'h4', "popular movies"
    end
  end

  test "should get about" do
    get about_path
    assert_response :success
  end
end