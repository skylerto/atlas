require 'test_helper'

class BuildControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get build_show_url
    assert_response :success
  end

end
