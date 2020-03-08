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

  test "get activity_stream" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/activity_stream"

    assert_response :success

    assert_includes response.parsed_body, 'sync-changes'
  end

  test "get event" do
    perform_successful_login

    get "/admin/instances/#{default_instance_id}/access/event/150"

    assert_response :success

    assert_includes response.parsed_body, 'sync-changes'
  end
end
