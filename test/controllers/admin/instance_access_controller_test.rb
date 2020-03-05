require 'test_helper'

class AdminInstanceAccessControllerTest < ActionDispatch::IntegrationTest
  test "get deployments" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/deployments"

    assert_response :success

    assert_includes response.parsed_body, 'success'
    assert_includes response.parsed_body, 'failed'
    assert_includes response.parsed_body, 'days ago'
  end
end
