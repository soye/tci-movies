require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "missing page redirects to 404" do
    get '/nonexistent'

    assert_response :missing
    assert_select 'h4', "Sorry, we couldn't find the page you were looking for."
  end
end