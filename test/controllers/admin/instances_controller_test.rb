require 'test_helper'

class AdminInstancesControllerTest < ActionDispatch::IntegrationTest
  test "get summary instances" do
    perform_successful_login

    get '/admin/instances.json'

    assert_response :success

    assert_equal response.parsed_body.length, 2
    assert_equal response.parsed_body[0]['site_name'], 'mytestt5667'
  end
end
